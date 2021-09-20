#!/bin/sh

download_canada() {
    precincts=$1
    enabled=$2
    filename=$3

    prefix="Canada"
    cookie="EDResults2=ItemList=$precincts&ResultTypeList=$enabled;"
    url="https://enr.elections.ca/ElectoralDistricts.aspx?lang=e"

    mkdir -p "./$prefix"
    echo "$url" "$cookie" "$filename"
    curl -b "$cookie" -c /tmp/cookies.txt --compressed --connect-timeout 10 -m 10 -s "$url" | grep -v '_VIEWSTATE' > "$prefix/$filename"
}

gitupload() {
    prefix=$1

    # Use git to find differences and push to github
    git add -A $prefix
    git diff --cached --name-only | cat
    git add log.txt

    updated=$(git diff --name-only --cached $prefix | xargs)

    git commit --author "Automated Script <run@localhost>" -m "$updated" | cat
    git log --name-status HEAD^..HEAD | cat

    git push origin master
}
