# $1 -> Starting commit <won't be conted>
# $2 -> Last commit
# $3 -> Aditional parameters
# $4 -> Aditional people

adicional_people=$4

lists=$(git show ${1}..${2} | perl scripts/get_maintainer.pl |grep list |awk '{printf $1", "}')
people=$(git show ${1}..${2} | perl scripts/get_maintainer.pl --nokeywords --no-rolestats --nol --separator ,),$adicional_people

#git format-patch --to="$(echo $people | cut -d',' -f 1)" --cc="$(echo $people | cut -d',' -f 2-)" --cover ${1}..${2}
git format-patch $3 --to="$people" --cc="$lists" --cover-letter ${1}..${2}
