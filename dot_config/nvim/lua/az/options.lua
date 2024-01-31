-- Disable GUI cursor in the terminal
vim.opt.guicursor = ""

-- Display line numbers and relative line numbers
vim.opt.number = true
vim.opt.relativenumber = true

-- Make new split windows open below and to the right of the current window
vim.opt.splitbelow = true
vim.opt.splitright = true

-- Enable smart indenting
vim.opt.smartindent = true

-- Set time in milliseconds for updating the screen and waiting before triggering a mapping
vim.opt.updatetime = 100
vim.opt.timeoutlen = 500

-- Enable incremental search
vim.opt.incsearch = true

-- Enable mouse support in all modes
vim.opt.mouse = "a"

-- Enable case-insensitive searching unless the search pattern contains uppercase letters
vim.opt.ignorecase = true
vim.opt.smartcase = true

-- Enable persistent undo, set undo directory, and disable swap files, backups, and write backups
vim.opt.undofile = true
vim.opt.undodir = os.getenv("HOME") .. "/.vim/undodir"
vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.writebackup = false

-- Set minimum number of screen lines to keep above and below the cursor
vim.opt.scrolloff = 8

-- Always display the sign column
vim.opt.signcolumn = "yes"

-- Set completion options to show a popup menu with one match and not select anything automatically
vim.opt.completeopt = "menuone,noselect"

-- Enable true color support in the terminal
vim.opt.termguicolors = true

-- Configure netrw plugin to not split the window when browsing directories, not display the banner, and set the window size to 25 lines
vim.g.netrw_browse_split = 0
vim.g.netrw_banner = 0
vim.g.netrw_winsize = 25

-- Enable mouse support in netrw
vim.g.netrw_mouse = 2
