function theme_update --on-variable OS_THEME
    if [ "$OS_THEME" = dark ]
        theme_dark
    else if [ "$OS_THEME" = light ]
        theme_light
    end
end
