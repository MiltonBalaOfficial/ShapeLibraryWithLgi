-- Load required modules
local stroke_io = require "stroke_io" -- Handles stroke file I/O
local insertion_helper = require "insertion_helper" -- Provides shape insertion functionality
local shape_update_helper = require "shape_update_helper"
local shape_dict, sep, sourcePath
local message2
local isAddShape, isAddShapeToExistingCategory, isAddShapeToNewCategory, isUpdateShape
local addShapeViewName, addShapeShapeName, addShapeCategoryName, addShapeNewCategoryName

-- Initialize the module table
local _M = {}

-- Check for lgi module (for Gtk GUI functionality)
local hasLgi, lgi = pcall(require, "lgi")
if not hasLgi then
    app.openDialog(
        "You need to have the Lua lgi-module installed and included in your Lua package path in order to use the GUI for this plugin. \n\n",
        {"OK"}, "", true)
    return
end
-- Import Gtk and Gdk from lgi
local Gtk = lgi.require("Gtk", "3.0")
local Gdk = lgi.require("Gdk", "3.0")

-- Function to load config.lua file for dictionary data
function loadConfig()
    local configFilePath = sourcePath .. "config.lua"
    return dofile(configFilePath)
end

function initUi()
    sep = package.config:sub(1, 1) -- OS-specific path separator
    sourcePath = debug.getinfo(1).source:match("@?(.*" .. sep .. ")")

    -- Load the config.lua file for the first time, if the file is edited then it should be loaded again for using the config file dynamically
    shape_dict = loadConfig()

    app.registerUi({
        menu = "Shape Library (Lgi)",
        callback = "show_main_shape_dialog",
        toolbarId = "shapeDialog",
        iconName = "shapes_symbolic",
        accelerator = "y"
    })
end

-- Function to read strokes for a specific shape based on shape file name
function get_strokes(shape_name)
    local filepath = sourcePath .. "Shapes" .. sep .. shape_name .. ".lua"
    return stroke_io.read_strokes_from_file(filepath)
end

-- Function to compute the bounding box for a set of strokes
function compute_bounds(strokes)
    local min_x, min_y, max_x, max_y = math.huge, math.huge, -math.huge, -math.huge
    for _, stroke in ipairs(strokes) do
        for _, x in ipairs(stroke.x) do
            min_x = math.min(min_x, x)
            max_x = math.max(max_x, x)
        end
        for _, y in ipairs(stroke.y) do
            min_y = math.min(min_y, y)
            max_y = math.max(max_y, y)
        end
    end
    return {
        x = min_x,
        width = max_x - min_x,
        y = min_y,
        height = max_y - min_y
    }
end

-- convert Shape name string to camel case (needed for make a shape file name from the user provided shape name)
function toCamelCase(str)
    local words = {}
    for word in str:gmatch("%S+") do
        table.insert(words, word:lower())
    end

    for i = 2, #words do
        words[i] = words[i]:gsub("^%l", string.upper)
    end

    return table.concat(words)
end

-- Function to draw the shape preview in the drawing area
function add_image_to_drawing_area(cr, shapeName, drawing_area)
        cr:set_source_rgba(1, 1, 1, 0) 
        cr:paint()

        -- Draw the border
        cr:set_line_width(1)         -- Border thickness
        cr:set_source_rgb(0.3, 0.3, 0.3)  -- Border color
        cr:rectangle(1, 1, 198, 98) -- Adjust dimensions for the border when the drawing area changes
        cr:stroke()

        -- Retrieve strokes for the given shape
        local strokes = get_strokes(shapeName)
        if not strokes or #strokes == 0 then
            return -- Exit if no strokes are available
        end

        -- Compute the bounding box of the strokes
        local bounds = compute_bounds(strokes)
        if bounds.width == 0 or bounds.height == 0 then
            return -- Avoid division by zero
        end

        -- Get the dimensions of the drawing area
        local width = drawing_area.width_request 
        local height = drawing_area.height_request

        -- Calculate scaling factors and translations
        local scale_x = width / bounds.width
        local scale_y = height / bounds.height
        local scale = math.min(scale_x, scale_y) * 0.8 -- Scale to fit, with padding

        -- Apply the check: if scale_factor > 1, don't scale, otherwise apply scaling
        if scale > 1 then
            scale = 1 + (scale - 1) * 0.2 -- Keep the actual size (slightly larger)
        end

        -- Center the shape in the drawing area
        local offset_x = (width - (bounds.width * scale)) / 2
        local offset_y = (height - (bounds.height * scale)) / 2

        -- Apply transformations
        cr:translate(offset_x, offset_y)
        cr:scale(scale, scale)
        cr:translate(-bounds.x, -bounds.y) -- Translate to the top-left of the shape

        -- Draw the strokes
        for _, stroke in ipairs(strokes) do
            if #stroke.x > 0 then

                local function decimal_to_rgb(color)
                    local r = (color >> 16) & 0xFF -- Extract the red component
                    local g = (color >> 8) & 0xFF -- Extract the green component
                    local b = color & 0xFF -- Extract the blue component
                    return r / 255, g / 255, b / 255 -- Normalize to 0-1 range
                end

                local color = stroke.color -- pick the stroke color from the file
                local r, g, b = decimal_to_rgb(color)
                cr:set_source_rgb(r, g, b)

                -- Define line type (dashed/dotted)
                local line_type = stroke.lineStyle
                if line_type == "dash" then
                    cr:set_dash({10, 5}, 0) -- Dash of length 10, gap of 5
                elseif line_type == "dot" then
                    cr:set_dash({2, 4}, 0) -- Dot of length 2, gap of 4
                elseif line_type == "dashdot" then
                    cr:set_dash({10, 5, 2, 5}, 0) -- Dash of length 10, gap of 5, dot of length 2, gap of 5
                else
                    cr:set_dash({}, 0) -- Solid line (no dashes)
                end

                -- Adjust line thickness based on the scale factor
                local base_thickness = stroke.width -- Base thickness for normalized scale
                local line_thickness = base_thickness / scale * 1.2 -- 20% thicker for better view

                local has_pressure = stroke.pressure and #stroke.pressure > 0
                if has_pressure then -- breaks the stroke into line segments to simulate variable width for a stroke 
                    local default_pressure = line_thickness

                    for i = 2, #stroke.x do
                        cr:move_to(stroke.x[i - 1], stroke.y[i - 1])
                        cr:line_to(stroke.x[i], stroke.y[i])
                        -- Adjust line width dynamically for each segment
                        local line_width = has_pressure and stroke.pressure[i] or default_pressure
                        cr:set_line_width(line_width)
                        cr:stroke() -- Draw the current segment
                    end
                else -- if no pressure value then width is a usual (if this is not used then fill property won't work for segmented strokes)
                    cr:set_line_width(line_thickness)

                    cr:move_to(stroke.x[1], stroke.y[1])
                    for i = 2, #stroke.x do
                        cr:line_to(stroke.x[i], stroke.y[i])
                    end
                end

                if stroke.fill > 2 then --Some strokes have fill = 1 though no need, so to avoid this I use 2 here
                    local opacity = stroke.fill / 255
                    cr:set_source_rgba(r, g, b, opacity)
                    cr:fill_preserve() -- Fill the shape but keep the path for stroking
                end
                cr:stroke()
            end
        end
    end

    -- Helper function to escape special characters in dynamic_text
    function escapeMarkup(text)
        return text:gsub("&", "&amp;"):gsub("<", "&lt;"):gsub(">", "&gt;")
    end
        
    -- Function to update the label text dynamically
    function updateMessage(label, dynamic_text)
        local escaped_text = escapeMarkup(dynamic_text)
        local new_text = string.format("<span foreground='orange'>%s</span>", escaped_text)
        label:set_label(new_text)
        label:set_use_markup(true)
    end

    -- Function to create or update a grid layout
    local function create_grid(grid, category_name)
        if grid then -- If the grid already exists, remove all its children
            for _, child in ipairs(grid:get_children()) do
                grid:remove(child)
            end
        else
            grid = Gtk.Grid {
                column_spacing = 10,
                row_spacing = 1,
                column_homogeneous = true
            }
        end

        local row, col = 0, 0
        local max_columns = 3
        local selected_category = nil

        -- Find the selected category
        for _, category in ipairs(shape_dict) do
            if category.name == category_name then
                selected_category = category
                break
            end
        end

        -- Default to the first category if not found
        selected_category = selected_category or shape_dict[1]

        -- Populate the grid with shapes from the selected category
        for _, shape in ipairs(selected_category.shapes) do
            local button = Gtk.Button {
                label = shape.name,
                height_request = 30
            }
            button.on_clicked = function()
                if isAddShape then -- when adding shape on click it will provide the shape name without inserting any shape
                    updateMessage(message2, shape.name)
                    addShapeShapeName = shape.shapeName
                else
                    -- Use the insert_shape_to_app function from the helper module
                    insertion_helper.insert_stroke(shape.shapeName)
                end

            end

            local drawing_area = Gtk.DrawingArea {
                width_request = 200,
                height_request = 100
            }
            drawing_area.on_draw = function(_, cr)
                add_image_to_drawing_area(cr, shape.shapeName, drawing_area)
                return true
            end

            grid:attach(button, col, row * 2 + 1, 1, 1)
            grid:attach(drawing_area, col, row * 2, 1, 1)

            col = col + 1
            if col >= max_columns then
                col = 0
                row = row + 1
                -- Add a separator after each full row of shapes
                local separator = Gtk.Separator {
                    orientation = Gtk.Orientation.HORIZONTAL,
                    margin_bottom = 10
                }
                grid:attach(separator, 0, row * 2, max_columns, 1)
                separator:show()
                row = row + 1
            end
        end
        return grid
    end

-- Show Main window for Shape Library
function show_main_shape_dialog()
    local Cairo = lgi.cairo

    -- initially value will be nil
    isAddShape, isAddShapeToExistingCategory, isAddShapeToNewCategory, isUpdateShape = nil, nil, nil, nil
    addShapeViewName , addShapeShapeName, addShapeCategoryName, addShapeNewCategoryName = nil, nil, nil, nil

    -- Custom CSS for making the button appeared as active after click
    local customCssProvider = Gtk.CssProvider()
    customCssProvider:load_from_data([[
        button {
            transition: background-color 0.3s ease;
        }
        button:active {
            background:rgb(41, 42, 43); /* Darker background when clicked */
        }
        /* Style for the button when it remains in the 'active' state */
        button.active {
            background:rgb(34, 33, 33);  /* Coral background to indicate active state */
            color: #fff;          /* Change text color for contrast */
                    outline: none;
        box-shadow: none;
        }
    ]])

    -- Main window
    local window = Gtk.Window {
        title = "Shape Library",
        default_width = 100,
        default_height = 100,
        on_destroy = Gtk.main_quit
    }
    -- Center the window on the screen
    window:set_position(Gtk.WindowPosition.CENTER)

        -- Main vertical box to hold other horizontal box and separators
        local main_vertical_box = Gtk.Box {
            orientation = Gtk.Orientation.VERTICAL,
        }
        window:add(main_vertical_box)
        main_vertical_box:show()

            -- middle horizontal box for category grid and shape grid and undo redo buttons
            local middle_horizontal_box = Gtk.Box {
                orientation = Gtk.Orientation.HORIZONTAL,
            }
            main_vertical_box:pack_start(middle_horizontal_box, true, true, 0)
            middle_horizontal_box:show()

                -- Left panel for category selection
                local left_vertical_box = Gtk.Box {
                    orientation = Gtk.Orientation.VERTICAL,
                    margin_left = 12,
                    margin_right = 12
                }
                middle_horizontal_box:pack_start(left_vertical_box, false, false, 0)
                left_vertical_box:show()

                    -- Label above the category grid
                    local labelCategorySelection = Gtk.Label {
                        label = "<span foreground='orange'>Choose a Category</span>",
                        use_markup = true,
                        margin_bottom = 5
                    }
                    left_vertical_box:pack_start(labelCategorySelection, false, false, 0)
                    labelCategorySelection:show()

                    -- Category grid
                    local category_grid = Gtk.Grid {
                        row_spacing = 5
                    }
                    left_vertical_box:pack_start(category_grid, false, false, 0)

                    -- Label above Add shape button
                    local labelAddShape = Gtk.Label {
                        label = "<span foreground='orange'>Add your shape from selection</span>",
                        use_markup = true,
                        margin_top = 20,
                        margin_bottom = 5,
                    }
                    left_vertical_box:pack_start(labelAddShape, false, false, 0)
                    labelAddShape:show()

                    -- Add shape from selection Button with custom dynamic label
                    local add_or_update_shape_label_initial = Gtk.Label {
                        label = "<span foreground='green'>Add or Update Shape</span>",
                        use_markup = true,
                    }
                    add_or_update_shape_label_initial:show()

                    local add_or_update_shape_label_close = Gtk.Label {
                        label = "<span foreground='red'>Cancel Add or update</span>",
                        use_markup = true,
                    }
                    add_or_update_shape_label_close:show()

                    local add_or_update_shape_button = Gtk.Button {
                        --child = add_or_update_dynamic_button_label,
                        child = add_or_update_shape_label_initial,
                    }
                    left_vertical_box:pack_start(add_or_update_shape_button, false, false, 0)
                    add_or_update_shape_button:show()

                    local add_or_update_shape_button_close = Gtk.Button {
                        --child = add_or_update_dynamic_button_label,
                        child = add_or_update_shape_label_close,
                    }
                    left_vertical_box:pack_start(add_or_update_shape_button_close, false, false, 0)
                    add_or_update_shape_button_close:hide()

                -- vertical separator between category grid and shape grig
                local vertical_separator_middle_left_right = Gtk.Separator {
                    orientation = Gtk.Orientation.VERTICAL
                }
                middle_horizontal_box:pack_start(vertical_separator_middle_left_right, false, false, 0)
                vertical_separator_middle_left_right:show()

                -- Right panel for the shape grid
                local right_vertical_box = Gtk.Box {
                    orientation = Gtk.Orientation.VERTICAL,
                    margin_right = 12,
                    margin_left = 12,
                }
                middle_horizontal_box:pack_start(right_vertical_box, true, true, 0)

                    -- Label above the shape grid
                    local labelShapeSelection = Gtk.Label {
                        label = "<span foreground='orange'>Choose a Shape.</span>",
                        use_markup = true,
                        margin_top = 5,
                        margin_bottom = 5,
                    }
                    right_vertical_box:pack_start(labelShapeSelection, false, false, 0)

                    -- Scrolled window to hold the shape grid
                    local scrolled_window = Gtk.ScrolledWindow {
                        hscrollbar_policy = Gtk.PolicyType.NEVER,
                        vscrollbar_policy = Gtk.PolicyType.AUTOMATIC,
                        expand = true
                    }
                    local grid = create_grid(nil, nil)
                    scrolled_window:add(grid)
                    right_vertical_box:pack_start(scrolled_window, true, true, 0)

                    -- horizontal separator below the shape grid (scroll window)
                    local horizontal_separator_below_scrolled_window = Gtk.Separator {
                        orientation = Gtk.Orientation.VERTICAL,
                        margin_top = 5,
                    }
                    right_vertical_box:pack_start(horizontal_separator_below_scrolled_window, false, false, 0)

                    -- Horizontal box to hold the buttons under the shape grid
                    local horizontal_box_for_scrolled_window_menu = Gtk.Box {
                        orientation = Gtk.Orientation.HORIZONTAL,
                        spacing = 25,
                        margin_top = 10,
                        halign = Gtk.Align.CENTER -- Align the buttons in the middle horizontally
                    }
                    right_vertical_box:pack_start(horizontal_box_for_scrolled_window_menu, false, false, 0)

                        -- Undo Button
                        local undo_button = Gtk.Button {
                            label = "Undo",
                            width_request = 100,
                        }
                        horizontal_box_for_scrolled_window_menu:pack_start(undo_button, false, false, 0)
                    
                        -- Redo Button
                        local redo_button = Gtk.Button {
                            label = "Redo",
                            width_request = 100,
                        }
                        horizontal_box_for_scrolled_window_menu:pack_start(redo_button, false, false, 0)
                    
                        -- Deselect Button
                        local deselect_button = Gtk.Button {
                            label = "Deselect",
                            width_request = 100,
                        }
                        horizontal_box_for_scrolled_window_menu:pack_start(deselect_button, false, false, 0)
                    
                        -- Close Button
                        local close_button = Gtk.Button {
                            label = "Close",
                            width_request = 100,
                        }
                        horizontal_box_for_scrolled_window_menu:pack_start(close_button, false, false, 0)

                -- Show right vertical box with all its content
                right_vertical_box:show_all()

            -- Vertical box to hold the extra part of window when Shape is added
            local add_shape_main_vertical_box = Gtk.Box {
                orientation = Gtk.Orientation.VERTICAL,
            }
            main_vertical_box:pack_start(add_shape_main_vertical_box, false, false, 0)

                -- Create the separator to indicate extra part
                local horizontal_separator_above_shape_entry_fields = Gtk.Separator {
                    orientation = Gtk.Orientation.VERTICAL
                }
                add_shape_main_vertical_box:pack_start(horizontal_separator_above_shape_entry_fields, false, false, 0)

                -- Horizontal box for hold the add shape buttons on the left and input part on the right
                local add_shape_horizontal_box = Gtk.Box {
                    orientation = Gtk.Orientation.HORIZONTAL,
                }
                add_shape_main_vertical_box:pack_start(add_shape_horizontal_box, false, false, 0)

                    -- vertical box to hold the add shape buttons
                    local add_shape_button_vertical_box = Gtk.Box {
                        orientation = Gtk.Orientation.VERTICAL,
                        spacing = 5,
                        margin_left = 12,
                        margin_top = 20,
                        margin_right = 12,
                    }
                    add_shape_horizontal_box:pack_start(add_shape_button_vertical_box, false, false, 0)

                        -- Add shape to existing category Button
                        local add_shape_button = Gtk.Button {
                            label = "Add to existing category",
                            width_request = 220,
                        }
                        add_shape_button_vertical_box:pack_start(add_shape_button, false, false, 0)
                        add_shape_button:show()

                        -- Add shape to a new category Button
                        local add_shape_with_category_button = Gtk.Button {
                            label = "Add to new category",
                            width_request = 220,
                        }
                        add_shape_button_vertical_box:pack_start(add_shape_with_category_button, false, false, 0)
                        add_shape_with_category_button:show()

                        -- Add shape update existing Button
                        local update_existing_shape = Gtk.Button {
                            label = "Update existing shape",
                            width_request = 220,
                        }
                        add_shape_button_vertical_box:pack_start(update_existing_shape, false, false, 0)
                        update_existing_shape:show()

                    -- Create the separator between add shape buttons and entry part
                    local vertical_separator_between_button_and_entry = Gtk.Separator {
                        orientation = Gtk.Orientation.VERTICAL
                    }
                    add_shape_horizontal_box:pack_start(vertical_separator_between_button_and_entry, false, false, 0)
                    vertical_separator_between_button_and_entry:show()

                    -- vertical box to hold entry items
                    local add_shape_entry_vertical_box = Gtk.Box {
                        orientation = Gtk.Orientation.VERTICAL,
                        spacing = 10,
                        margin_right = 12,
                        margin_top = 12
                    }
                    add_shape_horizontal_box:pack_start(add_shape_entry_vertical_box, false, false, 0)

                        -- horizontal box to hold category entry fields
                        local category_input_horizontal_box = Gtk.Box {
                            orientation = Gtk.Orientation.HORIZONTAL,
                            spacing = 12,
                            margin_left = 12
                        }
                        add_shape_entry_vertical_box:pack_start(category_input_horizontal_box, false, false, 0)

                            -- category entry label
                            local label1 = Gtk.Label {
                                label = "Category Name:"
                            }
                            category_input_horizontal_box:pack_start(label1, false, false, 0)

                            -- category entry input 
                            local entry1 = Gtk.Entry {
                                placeholder_text = "Enter category name"
                            }
                            category_input_horizontal_box:pack_start(entry1, false, false, 0)

                            --Category entry message
                            local category_name = Gtk.Label {
                                -- label = string.format("<span foreground='orange'>%s</span>", addShapeMessage),
                                label = "<span foreground='orange'>First select a category from the category list above.</span>",
                                use_markup = true
                            }
                            category_input_horizontal_box:pack_start(category_name, false, false, 0)

                        -- horizontal box to hold shape name entry fields
                        local shape_name_input_horizontal_box = Gtk.Box {
                            orientation = Gtk.Orientation.HORIZONTAL,
                            spacing = 12,
                            margin_left = 12
                        }
                        add_shape_entry_vertical_box:pack_start(shape_name_input_horizontal_box, false, false, 0)

                            -- shape name entry label
                            local label2 = Gtk.Label {
                                label = "Shape File Name:"
                            }
                            shape_name_input_horizontal_box:pack_start(label2, false, false, 0)

                            -- shape name input field
                            local entry2 = Gtk.Entry {
                                placeholder_text = "Enter shape file name"
                            }
                            shape_name_input_horizontal_box:pack_start(entry2, false, false, 0)

                            -- Shape name entry message
                            message2 = Gtk.Label { -- it is set as global to modify it by a function before it.
                                label = "<span foreground='orange'>Select a shape from a selected category.</span>",
                                use_markup = true
                            }
                            shape_name_input_horizontal_box:pack_start(message2, false, false, 0)

                        -- horizontal box to hold the cancel and ok button for add Shape field
                        local add_shape_button_horizontal_box = Gtk.Box {
                            orientation = Gtk.Orientation.HORIZONTAL,
                            spacing = 12,
                            margin_left = 12
                        }
                        add_shape_entry_vertical_box:pack_end(add_shape_button_horizontal_box, false, false, 0)

                            -- Cancel button to Quit Add shape
                            local cancel_button = Gtk.Button {
                                label = "CANCEL"
                            }
                            add_shape_button_horizontal_box:pack_start(cancel_button, false, false, 0)

                            -- Ok button to add shape with user inputs
                            local ok_button = Gtk.Button {
                                label = "OK"
                            }
                            add_shape_button_horizontal_box:pack_start(ok_button, false, false, 0)

            -- Horizontal separator above the foot note
            local horizontal_separator_above_foot_note = Gtk.Separator {
                orientation = Gtk.Orientation.VERTICAL,
                margin_top = 5,
            }
            main_vertical_box:pack_start(horizontal_separator_above_foot_note, false, false, 0)
            horizontal_separator_above_foot_note:show()
        
            -- foot note label
            local foot_note = Gtk.Label {
                label = "<span foreground='orange'>Don't forget to share your shape with us. Thank You.</span>",
                use_markup = true,
                margin = 3
            }
            main_vertical_box:pack_start(foot_note, false, false, 0)
            foot_note:show()


    -- Add category buttons to the category grid and handle click and manage active state            
    local previousCategoryButton = nil

    for i, category_data in ipairs(shape_dict) do
        -- Create a button with an initial magenta label
        local CategoryButton = Gtk.Button {
            label = category_data.name,
            width_request = 220,
            margin_bottom = 5
        }

        -- Apply initial style to the button label
        local buttonContext = CategoryButton:get_style_context()
        buttonContext:add_provider(customCssProvider, Gtk.STYLE_PROVIDER_PRIORITY_USER)

        -- Attach the button to the grid
        category_grid:attach(CategoryButton, 0, i - 1, 1, 1)

        -- Set the first button as active by default
        if i == 1 then
            -- Add the "active" class to the first button
            buttonContext:add_class("active")
            previousCategoryButton = CategoryButton
            updateMessage(category_name, category_data.name)
        end

        -- Handle button click to toggle active state
        CategoryButton.on_clicked = function()
            updateMessage(category_name, category_data.name)
            if isAddShape then
                --updateMessage(category_name, category_data.name)
                updateMessage(message2, "Select a shape under the category.")
                if isAddShapeToExistingCategory then
                    addShapeCategoryName = category_data.name
                end
            end

            -- create grid with the category name
            grid = create_grid(grid, category_data.name) -- provide the shape name
            scrolled_window:show_all()

            -- If there was a previously active button, remove the active class
            if previousCategoryButton then
                previousCategoryButton:get_style_context():remove_class("active")
            end

            -- Add the "active" class to the clicked button
            buttonContext:add_class("active")

            -- Update the previous button reference
            previousCategoryButton = CategoryButton
        end
    end
    category_grid:show_all()


    local function setActive(button)
        -- Remove the active state from the previous button
        if previousShapeButton then
            previousShapeButton:get_style_context():remove_class("active")
        end

        -- Add the active state to the current button
        button:get_style_context():add_class("active")
        previousShapeButton = button
    end

    -- Handel Add Shape part clicked functions
    local previousShapeButton = nil    -- Manage active state

    -- Click handler for 'Add or Update Shape'
    add_or_update_shape_button.on_clicked = function()
        local status, isSelection = pcall(app.getStrokes, "selection") -- Use pcall to handle errors
        if not status or not isSelection or #isSelection == 0 then
            app.openDialog("First select your Shape!", {"OK"})
            window:destroy()
        end
        updateMessage(message2, "Select a shape under the category.")
        isAddShape = true
        add_shape_main_vertical_box:show()
        add_shape_horizontal_box:show()
        add_shape_button_vertical_box:show_all()
        right_vertical_box:set_sensitive(false)
        category_grid:set_sensitive(false)
        horizontal_separator_above_shape_entry_fields:show()
        add_or_update_shape_button_close:show()
        add_or_update_shape_button:hide()

        -- Do what addShapeToExistingCategoryButton do
        isAddShapeToExistingCategory = true
        isUpdateShape = false
        isAddShapeToNewCategory = false
        setActive(add_shape_button)
        add_shape_entry_vertical_box:show_all()
        entry1:hide()
        message2:hide()
        right_vertical_box:set_sensitive(false)
        category_grid:set_sensitive(true)
    end
    -- Add shape cancel button click handler as like as cancel button
    add_or_update_shape_button_close.on_clicked = function()
        add_shape_main_vertical_box:hide()
        add_shape_entry_vertical_box:hide()
        window:resize(300, 200) -- will shrink the main window
        right_vertical_box:set_sensitive(true)
        category_grid:set_sensitive(true)
        horizontal_box_for_scrolled_window_menu:set_sensitive(true)
        horizontal_separator_above_shape_entry_fields:hide()

        isAddShape, isAddShapeToExistingCategory, isAddShapeToNewCategory, isUpdateShape = nil, nil, nil, nil
        addShapeViewName , addShapeShapeName, addShapeCategoryName, addShapeNewCategoryName = nil, nil, nil, nil

        -- Deactivate the add shape buttons button
        add_shape_button:get_style_context():remove_class("active")
        add_shape_with_category_button:get_style_context():remove_class("active")
        update_existing_shape:get_style_context():remove_class("active")
        previousShapeButton = nil -- Clear the previousShapeButton reference

        add_or_update_shape_button_close:hide()
        add_or_update_shape_button:show()
    end

    -- Click handler and manage active state for add shape different buttons
    local function applyCss(button) -- Apply CSS to all buttons
        local context = button:get_style_context()
        context:add_provider(customCssProvider, Gtk.STYLE_PROVIDER_PRIORITY_USER)
    end
    applyCss(add_shape_button)
    applyCss(add_shape_with_category_button)
    applyCss(update_existing_shape)

    -- add shape to existing category click handler
    add_shape_button.on_clicked = function()
        isAddShapeToExistingCategory = true
        isUpdateShape = false
        isAddShapeToNewCategory = false
        setActive(add_shape_button)
        add_shape_entry_vertical_box:show_all()
        entry1:hide()
        message2:hide()
        right_vertical_box:set_sensitive(false)
        category_grid:set_sensitive(true)
    end

    -- add shape to new category click handler
    add_shape_with_category_button.on_clicked = function()
        isAddShapeToNewCategory = true
        isAddShapeToExistingCategory = false
        isUpdateShape = false
        setActive(add_shape_with_category_button)
        add_shape_entry_vertical_box:show_all()
        category_name:hide()
        message2:hide()
        right_vertical_box:set_sensitive(false)
        category_grid:set_sensitive(false)
    end

    -- add shape update click handler
    update_existing_shape.on_clicked = function()
        isUpdateShape = true
        isAddShapeToNewCategory = false
        isAddShapeToExistingCategory = false
        setActive(update_existing_shape)
        add_shape_entry_vertical_box:show_all()
        entry1:hide()
        entry2:hide()
        right_vertical_box:set_sensitive(true)
        category_grid:set_sensitive(true)
        horizontal_box_for_scrolled_window_menu:set_sensitive(false)
    end

    -- Click handler for Add Shape cancel button
    cancel_button.on_clicked = function()
        updateMessage(category_name, "First select a category from the category list above.")
        updateMessage(message2, "Select a shape under the category.")

        if add_shape_main_vertical_box:get_visible() then -- remove the add shape part
            add_shape_main_vertical_box:hide()
            add_shape_entry_vertical_box:hide()
            window:resize(300, 200) -- will shrink the main window
            right_vertical_box:set_sensitive(true)
            category_grid:set_sensitive(true)
            horizontal_box_for_scrolled_window_menu:set_sensitive(true)

            isAddShape, isAddShapeToExistingCategory, isAddShapeToNewCategory, isUpdateShape = nil, nil, nil, nil
            addShapeViewName , addShapeShapeName, addShapeCategoryName, addShapeNewCategoryName = nil, nil, nil, nil

            -- Deactivate the add shape buttons
            add_shape_button:get_style_context():remove_class("active")
            add_shape_with_category_button:get_style_context():remove_class("active")
            update_existing_shape:get_style_context():remove_class("active")
            previousShapeButton = nil -- Clear the previousShapeButton reference

            add_or_update_shape_button_close:hide()
            add_or_update_shape_button:show()
        end
    end


    -- Click handler for Add Shape ok button
    ok_button.on_clicked = function()
        local strokes = app.getStrokes("selection")
        if not strokes then
            error("First select your shape.")
        elseif isUpdateShape then -- When shape is added to 
            stroke_io.store_stroke_info_in_file(addShapeShapeName, strokes)

            -- set all nil
            isAddShape, isAddShapeToExistingCategory, isAddShapeToNewCategory, isUpdateShape = nil, nil, nil, nil
            addShapeViewName , addShapeShapeName, addShapeCategoryName, addShapeNewCategoryName = nil, nil, nil, nil

            -- refresh the window
            window:hide()
            window:show()

        elseif isAddShapeToExistingCategory then
            addShapeViewName = entry2.text
            addShapeShapeName = toCamelCase(addShapeViewName) -- prepare a file name (shapeName)
            stroke_io.store_stroke_info_in_file(addShapeShapeName, strokes)
            shape_update_helper.updateDictionary(addShapeCategoryName, addShapeViewName, addShapeShapeName, nil)
            addShapeShapeName, addShapeCategoryName, isAddShapeToExistingCategory = nil, nil, nil

            -- Dynamically load the config.lua file after add entry
            shape_dict = loadConfig()
            -- closes the window and reopen it
            window:destroy()
            show_main_shape_dialog()

        elseif isAddShapeToNewCategory then
            addShapeNewCategoryName = entry1.text
            addShapeViewName = entry2.text
            addShapeShapeName = toCamelCase(addShapeViewName)
            stroke_io.store_stroke_info_in_file(addShapeShapeName, strokes)
            shape_update_helper.updateDictionary(nil, addShapeViewName, addShapeShapeName, addShapeNewCategoryName)
            addShapeShapeName, addShapeCategoryName, isAddShapeToNewCategory = nil, nil, nil

            -- Dynamically load the config.lua file after add entry
            shape_dict = loadConfig()
            window:destroy()
            show_main_shape_dialog()
        end
        add_or_update_shape_button_close:hide()
        add_or_update_shape_button:show()
    end




    -- Click handler of buttons below the shape GRID_SNAPPING
    undo_button.on_clicked = function()
        app.uiAction({action = "ACTION_UNDO"})
    end

    redo_button.on_clicked = function()
        app.uiAction({action = "ACTION_REDO"})
    end

    deselect_button.on_clicked = function()
        local refs = app.uiAction({action = "ACTION_SELECT_ALL"})
        app.clearSelection(refs)
    end

    close_button.on_clicked = function()
        window:destroy()
    end

    -- Show the window
    window:show()
    Gtk.main()
end

