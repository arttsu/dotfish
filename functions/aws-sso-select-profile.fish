function aws-sso-select-profile
    # Retrieve the list of AWS SSO profiles, excluding the header lines
    set profiles (aws-sso list | awk -F'|' 'NR>3 && $4!="" { print $4 }' | sed 's/^[ \t]*//;s/[ \t]*$//')

    if count $profiles > 0
        # Prompt the user to select a profile
        set selected_profile (printf "%s\n" $profiles | fzf)
        
        if test -n "$selected_profile"
            # Export the AWS_PROFILE variable
            set -xg AWS_PROFILE $selected_profile
            
            echo "AWS_PROFILE set to $AWS_PROFILE"
        else
            echo "No profile selected."
        end
    else
        echo "No AWS SSO profiles found."
    end
end
