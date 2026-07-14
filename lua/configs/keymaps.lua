-- Teclas líder
vim.g.mapleader = " "
vim.g.maplocalleader = " "


-- Comportamento da tecla <Tab>
vim.o.tabstop = 4 -- Um caractere TAB parece ser 4 espaços
vim.o.expandtab = true -- Pressionar TAB irá inserir espaços ao invés de um caractere TAB
vim.o.softtabstop = 4 -- O número de espaços inseridos ao pressionar TAB
vim.o.shiftwidth = 4 -- Número de espaços inseridos quando indentando


-- Explorador de arquivos
vim.g.netrw_banner = 0 -- Esconde o banner de ajuda no topo
vim.g.netrw_liststyle = 3 -- Modo de árvore (Tree view)
vim.g.netrw_browse_split = 4 -- Abre arquivos na janela anterior
vim.g.netrw_altv = 1 -- Abre splits verticalmente à direita
vim.g.netrw_winsize = 25 -- Define a largura da janela como 25%
vim.keymap.set("n", "<leader>e", ":Lexplore<CR>", { silent = true })


-- Procura de arquivos por nome
vim.opt.path:append("**") -- Passa a buscar em todas as subpastas recursivamente
vim.opt.wildmenu = true -- Apertar Tab durante a busca abre um menu flutuante
vim.opt.wildmode = "longest:full,full" -- A maneira como o menu flutuante é apresentado
vim.keymap.set("n", "<leader>p", ":find ") -- Busca por nome de arquivo


-- Procura de arquivos por conteúdo
vim.keymap.set("n", "<leader>f", function()
    local target = vim.fn.input("Content to search for: ")
    if target == "" then
        return
    end

    -- Executa o grep silenciosamente e abre a lista de resultados em uma Location List
    vim.cmd("silent lgrep! " .. vim.fn.escape(target, " "))
    vim.cmd("lopen")
end)


-- Atalhos dos LSPs
vim.api.nvim_create_autocmd('LspAttach', {
  callback = function(args)
    local opts = { buffer = args.buf }
    vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts) -- Vai a definição de um símbolo
    vim.keymap.set('n', 'gu', vim.lsp.buf.references, opts) -- Lista todos os locais onde o símbolo é usado
    vim.keymap.set('n', '<leader>r', vim.lsp.buf.rename, opts) -- Renomeia o símbolo semanticamente

    -- Aplica ações automáticas
    -- Por exemplo: importa biblioteca ausente, extrai função ou corrige erro de sintaxe.
    vim.keymap.set('n', '<leader>ca', vim.lsp.buf.code_action, opts)

    -- Avança para o próximo erro/warning e abre a janela flutuante automaticamente
    vim.keymap.set('n', 'gj', function() vim.diagnostic.jump({ count = 1, float = true }) end, opts)
    -- Retorna para o erro/warning anterior e abre a janela flutuante automaticamente
    vim.keymap.set('n', 'gk', function() vim.diagnostic.jump({ count = -1, float = true }) end, opts)
    -- Joga todos os erros/warnings na lista Quickfix e a abre
    vim.keymap.set('n', '<leader>q', function()
        vim.diagnostic.setqflist()
        vim.cmd("copen")
    end, opts)
  end,
})


-- Formatação
local lsps = require("configs.lsps")
vim.keymap.set("n", "<leader>fmt", lsps.format_current_buffer) -- Formata o arquivo atual
-- Formata o arquivo atual quando o usuário tentar salvá-lo com `:w`
vim.api.nvim_create_autocmd("BufWritePre", {callback = lsps.format_current_buffer})


-- Clipboard
vim.opt.clipboard = "unnamedplus"


-- Comentários
vim.keymap.set("n", "<leader>/", "gcc", { remap=true })
vim.keymap.set("v", "<leader>/", "gc", { remap=true })
