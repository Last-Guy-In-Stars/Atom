#!/bin/bash
while IFS="," read -r LastName FirstName Groups
do
    # LOGIN=$LastName
    echo P@ssw0rd | echo P@ssw0rd | ipa user-add "${LastName}" --first="${FirstName}" --last="${LastName}" --password
    ipa user-mod "${LastName}" --setattr=krbPasswordExpiration=20251212121212Z
    ipa group-add-member "${Groups}" --users="${LastName}"
done < <(tail -n +2 /root/users.csv)