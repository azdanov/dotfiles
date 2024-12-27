function update_theme --on-variable OS_Theme
    if [ "$OS_Theme" = "dark" ]
        set_theme_dark
    else if [ "$OS_Theme" = "light" ]
        set_theme_light
    end
end