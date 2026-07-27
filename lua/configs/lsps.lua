local M = {}

M.servers = {
    {
        name = "clangd",
        cmd = {"clangd"},
        filetypes = {"c", "cpp"},
        formatter = "clang-format -i",
    },
    {
        name = "pyright",
        cmd = {"pyright-langserver", "--stdio"},
        filetypes = {"python"},
        formatter = "black",
    },
    {
        name = "tsc",
        cmd = {"tsc", "--lsp", "--stdio"},
        filetypes = {"javascript", "typescript"},
        formatter = "prettier --write",
    },
    {
        name = "svelte",
        cmd = {"svelteserver", "--stdio"},
        filetypes = {"svelte"},
        formatter = "prettier --plugin-search-dir . --write",
    },
    {
        name = "rust_analyzer",
        cmd = {"rust-analyzer"},
        filetypes = {"rust"},
        formatter = "rustfmt",
    },
    {
        name = "lua_ls",
        cmd = {"lua-language-server"},
        filetypes = {"lua"},
        formatter = "stylua",
        settings = {
            Lua = {
                runtime = {
                    version = 'LuaJIT', -- Neovim usa LuaJIT
                },
                diagnostics = {
                    globals = { 'vim' }, -- Faz o LSP reconhecer o 'vim' global
                },
                workspace = {
                    -- Faz o LSP conhecer as APIs nativas do Neovim
                    library = vim.api.nvim_get_runtime_file("", true),
                    checkThirdParty = false,
                },
                telemetry = {
                    enable = false,
                },
            },
        },
    },
    {
        name = "hls",
        cmd = {"haskell-language-server-wrapper", "--lsp"},
        filetypes = {"haskell"},
        formatter = "ormolu -i",
    },
}


-- Função auxiliar que lida com a inicialização de um cliente LSP.
local function start_lsp(server)
    local root_dir = vim.fn.getcwd()
    vim.lsp.start({
        name = server.name,
        cmd = server.cmd,
        root_dir = root_dir,
        filetypes = server.filetypes,
        settings = server.settings or {},
    })
end


-- "autocmd" que será executado sempre que o evento "FileType" for dispa-
-- rado. Esse evento é disparado sempre que um arquivo é aberto e informa
-- o tipo (a extensão) do arquivo.
vim.api.nvim_create_autocmd("FileType", {
    callback = function(args)
        for _, server in ipairs(M.servers) do
            if vim.tbl_contains(server.filetypes, args.match) then
                start_lsp(server)
                break
            end
        end
    end,
})


M.format_current_buffer = function()
    local ft = vim.bo.filetype
    local server
    for _, candidate_server in ipairs(M.servers) do
        if vim.tbl_contains(candidate_server.filetypes, ft) then
            server = candidate_server
            break
        end
    end

    if not server or not server.formatter then
        print("No formatter found for filetype '" .. ft .. "'.")
        return
    end

    -- Executa o comando no arquivo atual
    vim.cmd("silent ! " .. server.formatter .. " " .. vim.fn.expand("%"))
    -- Recarrega o buffer para aplicar as mudanças visuais
    vim.cmd("checktime")
    print("Formatted with " .. server.formatter)
end


return M
