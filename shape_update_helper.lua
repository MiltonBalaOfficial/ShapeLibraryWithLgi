local sep = package.config:sub(1, 1) -- path separator depends on OS
local sourcePath = debug.getinfo(1).source:match("@?(.*" .. sep .. ")")

local _M = {} -- functions to export


-- Function to read, modify, and write back to the shapes file
function _M.updateDictionary(categoryName, shapeName, shapeFileName, newCategoryName)
    --app.openDialog("hepler connect",{"OK"})
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


end




return _M