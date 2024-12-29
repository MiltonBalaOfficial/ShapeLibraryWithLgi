-- Import LGI for GTK UI integration
function importLgi()
    local hasLgi, lgi = pcall(require, "lgi")
        if not hasLgi then 
            error("You need to have the Lua lgi-module installed and included in your Lua package path in order to use the GUI for the plugin.")
        end
        Gtk = lgi.require("Gtk", "3.0")
        Gdk = lgi.require("Gdk", "3.0")
end

local shapes_dict, sep, sourcePath

function initUi()
    sep = package.config:sub(1, 1) -- OS-specific path separator
    sourcePath = debug.getinfo(1).source:match("@?(.*" .. sep .. ")")

    -- Load the config.lua file for the first time, if the file is edited then it should be loaded again for using the config file dynamically
    shapes_dict = loadConfig()

    app.registerUi({
        menu = "Shape Library",
        callback = "show_main_shape_dialog",
        toolbarId = "shapeDialog",
        iconName = "shapes_symbolic",
        accelerator = "y",
    })
end

-- Function to load config.lua file for dictionary data
function loadConfig()
    local configFilePath = sourcePath .. "config.lua"
    return dofile(configFilePath)
end

-- Read strokes from a file and return formatted strokes
function read_strokes_from_file(filepath)
    if filepath == nil then return end
    local hasFile, content = pcall(dofile, filepath)
    if not hasFile then print("Error: " .. content) return end

    local strokesToAdd = {}
    for _, stroke in ipairs(content) do
        if type(stroke) == "table" and stroke.x and stroke.y then
            local newStroke = {
                x = stroke.x, y = stroke.y,
                pressure = stroke.pressure,
                tool = stroke.tool or "pen",
                color = stroke.color or 0,
                width = stroke.width or 1,
                fill = stroke.fill or 0,
                lineStyle = stroke.lineStyle or "plain"
            }
            table.insert(strokesToAdd, newStroke)
        end
    end
    return strokesToAdd
end

-- Insert stroke function
function insert_stroke(shape_name)
    local filepath = sourcePath .. "Shapes" .. sep .. shape_name .. ".lua"
    local strokes = read_strokes_from_file(filepath)
    if strokes and #strokes > 0 then
        local refs = app.addStrokes({ strokes = strokes, allowUndoRedoAction = "grouped" })
        app.refreshPage()
        app.addToSelection(refs)
    end
end

-- Function to show the main shape dialog (GTK Window)
local currentCategory = nil

function show_main_shape_dialog(isUpdateFile, updatedStroke)
    importLgi() -- import Lgi
    local window = Gtk.Window {
        title = "☆ Shape Library ☆",
        default_width = 600,
        default_height = 400,
        on_destroy = function() window:hide() end
    }

    -- Center the window on the screen
    window:set_position(Gtk.WindowPosition.CENTER)  -- This centers the window on the screen

    local vbox = Gtk.Box { orientation = Gtk.Orientation.VERTICAL, spacing = 10, margin = 10 }

    if isUpdateFile then 
        -- Create a a label above the categories when user wants to update the shape
        local labelCategorySelection = Gtk.Label { label = "Choose a Category to update the Shape"}
        labelCategorySelection:set_markup("<span foreground='orange'>Choose a Category to update the Shape</span>") -- colored text
        vbox:pack_start(labelCategorySelection, false, false, 0)
    else
        -- Create a a label above the categories when inserting the shape
        local labelCategorySelection = Gtk.Label { label = "Choose a Category to insert Shape"}
        labelCategorySelection:set_markup("<span foreground='orange'>Choose a Category to insert Shape</span>") -- colored text
        vbox:pack_start(labelCategorySelection, false, false, 0)
    end
    
    -- Add buttons for each shape category
    for i, category in ipairs(shapes_dict) do
        local button = Gtk.Button { label = category.name }
        button.on_clicked = function()
            currentCategory = i
            window:hide()
            show_shape_dialog(i, isUpdateFile, updatedStroke)
        end
        vbox:pack_start(button, false, false, 0)
    end

    -- Create horizontal separator (above the add shape button)
    local horizontal_separator_above_add_shape = Gtk.Separator { orientation = Gtk.Orientation.HORIZONTAL }
    vbox:pack_start(horizontal_separator_above_add_shape, false, false, 0)



    if isUpdateFile then 
        -- Create a a label for caution when update the existing shapes
        local labelCaution = Gtk.Label { label = ""}
        labelCaution:set_markup("<span foreground='red'>➢ Once updated, you cannot get back the old shape!\n Keep backup of the 'Shapes' folder!</span>") -- colored text
        vbox:pack_start(labelCaution, false, false, 0)

        -- Back Button
        local back_button = Gtk.Button { label = "Back" }
            back_button.on_clicked = function() 
            window:hide()
            extractInfoMainDialog()
        end
        vbox:pack_start(back_button, false, false, 0)
    else
        -- Create a a label above the add shape button when insert the shape
        local labelAddShape = Gtk.Label { label = "Add selected Shape to Shape Library"}
        labelAddShape:set_markup("<span foreground='orange'>Add selected Shape to Shape Library</span>") -- colored text
        vbox:pack_start(labelAddShape, false, false, 0)

        -- Add shape Button
        local add_shape_button = Gtk.Button { label = "Add or update Shape" }
        add_shape_button.on_clicked = function() 
            extractInfoMainDialog()
            window:hide() 
        end
        vbox:pack_start(add_shape_button, false, false, 0)

        -- Create horizontal separator (above the Cancel button)
        local horizontal_separator_above_cancel = Gtk.Separator { orientation = Gtk.Orientation.HORIZONTAL }
        vbox:pack_start(horizontal_separator_above_cancel, false, false, 010)

        -- Cancel Button
        local cancel_button = Gtk.Button { label = "Cancel" }
        cancel_button.on_clicked = function() 
            window:hide() 
        end
        vbox:pack_start(cancel_button, false, false, 0)
    end



    -- Create horizontal separator above footnote
    local horizontal_separator_above_foot_note = Gtk.Separator { orientation = Gtk.Orientation.HORIZONTAL }
    vbox:pack_start(horizontal_separator_above_foot_note, false, false, 0)

    -- Create a a label above footnote
    local labelFootNote = Gtk.Label { label = "Don't forget to share your shapes with us! Thank you."}
    labelFootNote:set_markup("<span foreground='pink'>Don't forget to share your shapes with us! Thank you.</span>") -- colored text
    vbox:pack_start(labelFootNote, false, false, 0)

    window:add(vbox)
    window:show_all()
end

-- Function to show the shape selection dialog (GTK Window)
function show_shape_dialog(categoryIndex, isUpdateFile, updatedStroke )
    local window = Gtk.Window {
        title = "☆ Shape Library ☆",
        default_width = 600,
        default_height = 400,
        on_destroy = function() 
            window:hide() 
        end
    }

    -- Center the window on the screen
    window:set_position(Gtk.WindowPosition.CENTER)  -- This centers the window on the screen

    local vbox = Gtk.Box { orientation = Gtk.Orientation.VERTICAL, spacing = 10, margin = 10 }

    local category = shapes_dict[categoryIndex]

    -- Add buttons for each shape
    for i, shape in ipairs(category.shapes) do
        local button = Gtk.Button { label = shape.name }
        button.on_clicked = function()
            window:hide()
            if isUpdateFile then -- for updating existing file 
                -- Proceed with initiating the function to store stroke info
                store_stroke_info_in_file(shape.shapeName, updatedStroke)
                window:hide()
            else -- for normal case shape will be inserted
            insert_stroke(shape.shapeName)
            end 
        end
        vbox:pack_start(button, false, false, 0)
    end


    -- Back Button
    local back_button = Gtk.Button { label = "Back" }
    back_button.on_clicked = function()
        window:hide()

        if isUpdateFile then -- when updating an existing file
            show_main_shape_dialog(isUpdateFile)
        else -- when inserting shapes
            show_main_shape_dialog()
        end
    end
    vbox:pack_start(back_button, false, false, 0)

    window:add(vbox)
    window:show_all()
end

-- writes a shape_stroke file with the shape name provided by the user
function store_stroke_info_in_file(shapeName, strokes)
    -- Open a file for writing in the folder path
    local file = assert(io.open(sourcePath .. "Shapes" .. sep .. shapeName .. ".lua", "w"))
    -- Start writing the Lua table format
    file:write("local strokesData = {\n")
    -- Iterate over each stroke and collect information
    for i, stroke in ipairs(strokes) do
        file:write(string.format("  [%d] = {\n", i))
        file:write("    x = { ")
        -- Write x coordinates
        for j = 1, #stroke.x do
            file:write(stroke.x[j])
            if j < #stroke.x then
                file:write(", ")
            end
        end
        file:write(" },\n")
        file:write("    y = { ")
        -- Write y coordinates
        for j = 1, #stroke.y do
            file:write(stroke.y[j])
            if j < #stroke.y then
                file:write(", ")
            end
        end
        file:write(" },\n")

        -- Write pressure values if present
        if stroke.pressure then
            file:write("    pressure = { ")
            for j = 1, #stroke.pressure do
                file:write(stroke.pressure[j])
                if j < #stroke.pressure then
                    file:write(", ")
                end
            end
            file:write(" },\n")
        else
            file:write("    pressure = {},\n")
        end

        -- Write stroke options
        file:write(string.format("    tool = \"%s\",\n", stroke.tool or "N/A"))
        file:write(string.format("    color = %s,\n", stroke.color or "N/A"))
        file:write(string.format("    width = %.2f,\n", stroke.width or 0.0))
        file:write(string.format("    fill = %d,\n", stroke.fill or 0))
        file:write(string.format("    lineStyle = \"%s\",\n", stroke.lineStyle or "N/A"))
        file:write("  },\n") -- End of stroke table
    end
    file:write("}\n")
    file:write("return strokesData")
    file:write("   -- Return the strokesData table") -- End of strokesData table

    -- Close the file
    file:close()
end

-- Function to display the extract info main dialog for user choice
function extractInfoMainDialog()
    importLgi() -- import Lgi
    local strokes = app.getStrokes("selection")
    if not strokes then
        error("First select your shape.")
    end
    -- Create the main window where users can choose a category
    local window = Gtk.Window {
        title = "Extract Shape Info",  -- Window title
        default_width = 600,  -- Default width of the window
        default_height = 400,  -- Default height of the window
        on_destroy = Gtk.main_quit,  -- Close the GTK application when the window is destroyed
    }

    -- Center the window on the screen
    window:set_position(Gtk.WindowPosition.CENTER)  -- This centers the window on the screen

    -- Create a vertical box (vbox) to organize elements vertically within the window
    local vbox = Gtk.Box {
        orientation = Gtk.Orientation.VERTICAL,  -- Stack the elements vertically
        spacing = 10,  -- Spacing between elements
        margin = 20,  -- Margin around the box
    }

    -- Add a label at the top of the vbox
    local label = Gtk.Label { label = "Select a category and give a name to your Shape." }
    label:set_markup("<span foreground='orange'>Select a category and give a name to your Shape.</span>") -- colored text
    vbox:pack_start(label, false, false, 0)  -- Add the label to the vbox (non-expandable)

    -- Dynamically create buttons for each category in the shapes_dict
    for _, category in ipairs(shapes_dict) do
        -- Create a button for each category
        local button = Gtk.Button { label = category.name }  -- Button label is the category name

        -- Action when the category button is clicked
        button.on_clicked = function()
            -- When a category button is clicked, show the input window for that category
            extractInfoInputDialogWithoutCategory(category.name,strokes)
            window:hide()  -- Hide the main window
        end

        -- Add the category button to the vbox
        vbox:pack_start(button, false, false, 0)
    end

    -- "Create New Category" button at the bottom
    local newCategory_button = Gtk.Button { label = "Create New Category" }
    newCategory_button.on_clicked = function()
        -- When the "Create New Category" button is clicked, hide the main window and show the new category input form
        window:hide()
        extractInfoInputDialogWithCategory(strokes)
    end
    vbox:pack_start(newCategory_button, false, false, 0)  -- Add the create button to the vbox

    -- "Update existing shape" button at the bottom
    local updateExisting_button = Gtk.Button { label = "Update Existing Shape" }
    updateExisting_button.on_clicked = function()
        window:hide()
        local isUpdateFile = true -- then opens the main category dialog, then user select category and then shape name, the shape name is given to write stroke function and it will replace the shape file
        show_main_shape_dialog(isUpdateFile, strokes)
    end
    vbox:pack_start(updateExisting_button, false, false, 0)  -- Add the create button to the vbox

    -- Back button at the bottom
    local back_button = Gtk.Button { label = "Back" }
    back_button.on_clicked = function()
        -- When the cancel button is clicked, hide the main window
        window:hide()
        show_main_shape_dialog()
    end
    vbox:pack_end(back_button, false, false, 0)  -- Add the cancel button to the vbox

    -- Add the vbox (containing all buttons) to the main window
    window:add(vbox)
    window:show_all()  -- Show the window and all its contents
end


-- the input window for existing categories
function extractInfoInputDialogWithoutCategory(categoryName, strokes)
    local window = Gtk.Window {
        title = "Add Shape to " .. categoryName,
        default_width = 400,
        default_height = 200,
        on_destroy = Gtk.main_quit,
    }

    window:set_position(Gtk.WindowPosition.CENTER)

    local vbox = Gtk.Box {
        orientation = Gtk.Orientation.VERTICAL,
        spacing = 10,
        margin = 20,
    }

    local label1 = Gtk.Label { label = "Shape File Name:" }
    local entry1 = Gtk.Entry { placeholder_text = "Enter shape file name" }

    local ok_button = Gtk.Button { label = "OK" }
    ok_button.on_clicked = function()
    
        local shapeName = entry1.text
    
        if shapeName and shapeName ~= "" then
            -- Proceed with initiating the function to store stroke info
                
                local ShapeFileNameCamel = toCamelCase(shapeName)
                store_stroke_info_in_file(ShapeFileNameCamel, strokes)
                updateDictionary(categoryName, shapeName, ShapeFileNameCamel, nil)
                --app.openDialog(ShapeFileNameCamel,{"OK"})
            -- Hide the window after processing
            window:hide()
        else
            print("Error: Shape file name must be filled out.")
        end
    end

    -- Back Button
    local back_button = Gtk.Button { label = "Back" }
    back_button.on_clicked = function()
        window:hide()
        extractInfoMainDialog()
    end

    vbox:pack_start(label1, false, false, 0)
    vbox:pack_start(entry1, false, false, 0)
    vbox:pack_start(ok_button, false, false, 10)
    vbox:pack_start(back_button, false, false, 0)
    window:add(vbox)
    window:show_all()
end

-- Overriding the input window for new categories
function extractInfoInputDialogWithCategory(strokes)
    local window = Gtk.Window {
        title = "Create New Category",
        default_width = 400,
        default_height = 200,
        on_destroy = Gtk.main_quit,
    }

    window:set_position(Gtk.WindowPosition.CENTER)

    local vbox = Gtk.Box {
        orientation = Gtk.Orientation.VERTICAL,
        spacing = 10,
        margin = 20,
    }

    local label1 = Gtk.Label { label = "Category Name:" }
    local entry1 = Gtk.Entry { placeholder_text = "Enter category name" }

    local label2 = Gtk.Label { label = "Shape File Name:" }
    local entry2 = Gtk.Entry { placeholder_text = "Enter shape file name" }

    local ok_button = Gtk.Button { label = "OK" }
    ok_button.on_clicked = function()
        local newCategoryName = entry1.text
        local shapeName = entry2.text
        if newCategoryName == "" or shapeName == "" then
            print("Error: All fields must be filled out.")
        else
            
            local ShapeFileNameCamel = toCamelCase(shapeName)
            store_stroke_info_in_file(ShapeFileNameCamel, strokes)
            updateDictionary(nil, shapeName, ShapeFileNameCamel, newCategoryName)
            window:hide()
        end
    end

    -- Back Button
    local back_button = Gtk.Button { label = "Back" }
    back_button.on_clicked = function()
        window:hide()
        extractInfoMainDialog()
    end

    vbox:pack_start(label1, false, false, 0)
    vbox:pack_start(entry1, false, false, 0)
    vbox:pack_start(label2, false, false, 0)
    vbox:pack_start(entry2, false, false, 0)
    vbox:pack_start(ok_button, false, false, 10)
    vbox:pack_start(back_button, false, false, 0)
    window:add(vbox)
    window:show_all()
end


-- convert Shape name string to camel case
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


-- Function to read, modify, and write back to the shapes file
function updateDictionary(categoryName, shapeName, shapeFileName, newCategoryName)
    -- Step 1: Load the file
    local filePath = sourcePath .. "config.lua"
    local shapesData, err = loadfile(filePath)
    if not shapesData then
        print("Error: Could not load file - " .. err)
        return
    end

    -- Execute the loaded function to get the shapes data
    shapesData = shapesData()

    -- Step 2: Modify the table by either finding the category or adding a new one
    local categoryFound = false

    if newCategoryName then
        -- If a new category name is provided, add the new category
        local newCategory = {
            name = newCategoryName,
            shapes = {
                { name = shapeName, shapeName = shapeFileName }
            }
        }
        -- Insert the new category at the beginning (index 1)
        table.insert(shapesData, newCategory)
        print("New category added: " .. newCategoryName .. " with shape: " .. shapeName)
    elseif categoryName then
        -- If no new category, find the existing one
        for _, category in ipairs(shapesData) do
            if category.name == categoryName then
                -- Find the next available key for shapes (next available index)
                local nextKey = #category.shapes + 1
                -- Add the new shape to the shapes table
                category.shapes[nextKey] = { name = shapeName, shapeName = shapeFileName }
                print("Shape added: " .. shapeName .. " in category " .. category.name)
                categoryFound = true
                break
            end
        end

        if not categoryFound then
            print("Error: Category not found!")
            return
        end
    end

    -- Step 3: Serialize the table back to Lua syntax
    local function serializeTable(tbl, indent)
        local result = ""
        for i, v in ipairs(tbl) do
            -- Start each category block
            result = result .. "[" .. i .. "] = {\n"
            result = result .. "    name = \"" .. v.name .. "\",\n"
            result = result .. "    shapes = {\n"
            
            -- Serialize the shapes within the category
            for j, shape in ipairs(v.shapes) do
                result = result .. "        [" .. j .. "] = {"
                result = result .. " name = \"" .. shape.name .. "\","
                result = result .. " shapeName = \"" .. shape.shapeName .. "\""
                result = result .. " },\n"
            end

            result = result .. "    },\n"
            result = result .. "},\n"
        end
        return result
    end

    -- Wrap the serialized table in a return statement
    local serializedData = "return {\n" .. serializeTable(shapesData, "    ") .. "}\n"

    -- Step 4: Write the updated data back to the file
    local file = io.open(filePath, "w")
    if file then
        file:write(serializedData)
        file:close()
        print("File updated successfully!")
    else
        print("Error: Could not write to file!")
    end

        -- Dynamically load the config.lua file after add entry
        shapes_dict = loadConfig()
end

