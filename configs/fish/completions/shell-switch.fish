# Disable standard file completions for this function
complete -c shell-switch -f

# Define the explicit word strings allowed as arguments
complete -c shell-switch -a "ambxst" -d "Switch to Ambxst Shell"
complete -c shell-switch -a "caelestia" -d "Switch to Caelestia Shell"
complete -c shell-switch -a "dms" -d "Switch to DankMaterialShell"
complete -c shell-switch -a "noctalia" -d "Switch to Noctalia Shell"
complete -c shell-switch -a "end4" -d "Switch to Illogical Impulse"