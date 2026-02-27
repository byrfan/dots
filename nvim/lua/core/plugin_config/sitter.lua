require'nvim-treesitter.configs'.setup {
	ensure_installed = {"python", "css", "cpp", "vim", "lua", "javascript", "java", "rust", "html", "c_sharp", "c"},
	sync_install = false,
	
	highlight = {
		enable = true,
        disable = {"html"}
	}
}
require('nvim-treesitter.parsers').get_parser_configs().asm = {
    install_info = {
        url = 'https://github.com/rush-rs/tree-sitter-asm.git',
        files = { 'src/parser.c' },
        branch = 'main',
    },
}
