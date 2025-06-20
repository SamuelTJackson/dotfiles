local ls = require "luasnip"
local f = ls.function_node
local s = ls.s
local i = ls.insert_node
local t = ls.text_node
local d = ls.dynamic_node
local c = ls.choice_node
local snippet_from_nodes = ls.sn

local ts_locals = require "nvim-treesitter.locals"
local ts_utils = require "nvim-treesitter.ts_utils"
local get_node_text = vim.treesitter.get_node_text

-- Adapted from https://github.com/tjdevries/config_manager/blob/1a93f03dfe254b5332b176ae8ec926e69a5d9805/xdg_config/nvim/lua/tj/snips/ft/go.lua
local function same(index)
    return f(function(args)
        return args[1]
    end, { index })
end

-- Adapted from https://github.com/tjdevries/config_manager/blob/1a93f03dfe254b5332b176ae8ec926e69a5d9805/xdg_config/nvim/lua/tj/snips/ft/go.lua
vim.treesitter.query.set(
    "go",
    "LuaSnip_Result",
    [[ [
    (method_declaration result: (_) @id)
    (function_declaration result: (_) @id)
    (func_literal result: (_) @id)
  ] ]]
)

-- Adapted from https://github.com/tjdevries/config_manager/blob/1a93f03dfe254b5332b176ae8ec926e69a5d9805/xdg_config/nvim/lua/tj/snips/ft/go.lua
local transform = function(text, info)
    if text == "int" then
        return t "0"
    elseif text == "error" then
        if info then
            info.index = info.index + 1

            return c(info.index, {
                -- fmt.Errorf with cursor inside message string
                sn(nil, {
                    t('fmt.Errorf("'),
                    i(1),
                    t(': %w", err)'),
                }),

                -- Alternative with same pattern
                sn(nil, {
                    t('fmt.Errorf("'),
                    i(1),
                    t(': %w", err)'),
                }),

                -- pkg/errors.Wrap with cursor in message
                sn(nil, {
                    t('errors.Wrap(err, "'),
                    i(1),
                    t('")'),
                }), })
        else
            return t "err"
        end
    elseif text == "bool" then
        return t "false"
    elseif text == "string" then
        return t '""'
    elseif string.find(text, "*", 1, true) then
        return t "nil"
    elseif string.find(text, "[]", 1, true) then
        return t "nil"
    elseif string.find(text, "map", 1, true) then
        return t "nil"
    end

    return t(text .. "{}")
end

local handlers = {
    ["parameter_list"] = function(node, info)
        local result = {}

        local count = node:named_child_count()
        for idx = 0, count - 1 do
            table.insert(result, transform(get_node_text(node:named_child(idx), 0), info))
            if idx ~= count - 1 then
                table.insert(result, t { ", " })
            end
        end

        return result
    end,

    ["type_identifier"] = function(node, info)
        local text = get_node_text(node, 0)
        return { transform(text, info) }
    end,
}

-- Adapted from https://github.com/tjdevries/config_manager/blob/1a93f03dfe254b5332b176ae8ec926e69a5d9805/xdg_config/nvim/lua/tj/snips/ft/go.lua
local function go_result_type(info)
    local cursor_node = ts_utils.get_node_at_cursor()
    local scope = ts_locals.get_scope_tree(cursor_node, 0)

    local function_node
    for _, v in ipairs(scope) do
        if
            v:type() == "function_declaration"
            or v:type() == "method_declaration"
            or v:type() == "func_literal"
        then
            function_node = v
            break
        end
    end

    local query = vim.treesitter.query.get("go", "LuaSnip_Result")
    for _, node in query:iter_captures(function_node, 0) do
        if handlers[node:type()] then
            return handlers[node:type()](node, info)
        end
    end

    return { t "nil" }
end

-- Adapted from https://github.com/tjdevries/config_manager/blob/1a93f03dfe254b5332b176ae8ec926e69a5d9805/xdg_config/nvim/lua/tj/snips/ft/go.lua
local go_ret_vals = function(args)
    return snippet_from_nodes(
        nil,
        go_result_type {
            index = 0,
        }
    )
end

return {
    -- Adapted from https://github.com/tjdevries/config_manager/blob/1a93f03dfe254b5332b176ae8ec926e69a5d9805/xdg_config/nvim/lua/tj/snips/ft/go.lua
    s("if", {
        t { "if err != nil {", "\treturn " },
        d(1, go_ret_vals),
        t { "", "}" },
        i(0),
    }),
}
