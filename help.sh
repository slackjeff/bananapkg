#!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
#
# HELP
#
#!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!

_HELP_US()
{
    cat <<EOF
banana - Low level package manager
banana [OPTION] [ARCHIVE]

MAIN ARGUMENTS
    -V, version
          Look version of Banana
    -h,help
          Show this message and exit
    -g, generate
          Generate directory info/ and into desc
    -c, create
          Create Package
    -i, install
          Install Package
    -u, upgrade
          Upgrade package
    update
          Update bananapkg via Internet
    -r, remove
          Remove Package
    -s, search
          Search Package        
    -ol, one-line
          Use in -s, search for print one line search.
          program-version-build       
    -v, verbose
          Look more
EOF
}
