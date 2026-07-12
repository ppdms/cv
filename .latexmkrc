# Use LuaLaTeX (required for fontspec/Inter)
$pdf_mode = 4;

# Place all auxiliary files in build/ directory
$aux_dir = 'build';

# Ensure the build directory exists
ensure_path('TEXINPUTS', './build//');
ensure_path('BIBINPUTS', './build//');
ensure_path('BSTINPUTS', './build//');

# Set compilation timestamp to current time
$ENV{'SOURCE_DATE_EPOCH'} = `date +%s`;
chomp($ENV{'SOURCE_DATE_EPOCH'});
