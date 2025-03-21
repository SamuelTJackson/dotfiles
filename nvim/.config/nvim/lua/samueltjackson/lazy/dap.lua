return {
    "rcarriga/nvim-dap-ui",
    dependencies = {
        "theHamsta/nvim-dap-virtual-text",
        "mfussenegger/nvim-dap",
        "nvim-neotest/nvim-nio",
    },
    ft = { 'go', 'gomod' },
    config = function()
        local dap = require("dap")
        dap.adapters.delve = function(callback, config)
            if config.mode == 'remote' and config.request == 'attach' then
                callback({
                    type = 'server',
                    host = config.host or '127.0.0.1',
                    port = config.port or '38697'
                })
            else
                callback({
                    type = 'server',
                    port = '${port}',
                    executable = {
                        command = 'dlv',
                        args = { 'dap', '-l', '127.0.0.1:${port}', '--log', '--log-output=dap' },
                        detached = vim.fn.has("win32") == 0,
                    }
                })
            end
        end

        local dapui = require("dapui")
        require("dapui").setup()
        dap.listeners.after.event_initialized["dapui_config"] = function()
            dapui.open()
        end
        dap.listeners.before.event_terminated["dapui_config"] = function()
            dapui.close()
        end
        dap.listeners.before.event_exited["dapui_config"] = function()
            dapui.close()
        end

        function load_config_and_continue()
            if vim.fn.filereadable('.nvim/dap.json') then
                require('dap.ext.vscode').load_launchjs('.nvim/dap.json', { delve = { 'go' } })
            end

            require('dap').continue()
        end

        vim.keymap.set("n", "<leader>dd", "<cmd>lua load_config_and_continue()<CR>")
        vim.keymap.set("n", "<leader>db", ":GoBreakToggle<CR>")
    end
}
