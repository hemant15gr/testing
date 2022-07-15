working_branch=$1
main_branch=$2
#commit_id=$(git log --format="%h" --after="1 day"| tail -1
commit_id=$(git log --after="yesterday" --format="%h" | tail -1)
git_url=https://github.com/andromeda360/a360-flux.git
status=$(kubectl get pods --all-namespaces | grep 'a360\|auth\|istio-system' | grep -v 'auth-jwt' | grep -v 'Running' | wc -l)
cat $commit_id
cat $status
if [ $status = 0 ]
then
   echo "All Pods of all namespaces are up and running"
else
   echo "Any Pod of any of the namespaces are not running kindly wait for next 10 min"
   sleep 600 #pause for 10 min
   if [ $status = 0 ]
   then
   echo "All Pods of all namespaces are up and running"
   else
   echo "Any of the Pods are not running,Kindly revert the cahnges"
   ##git log --oneline --graph
   ##git log --after="yesterday"
   git revert -m 1 $commit_id
   git push --set-upstream origin $working_branch
   gh pr create --title "PR has been created at $date as per previous Prod Running Sucessfully" --body "Reverted to previous woking state" --base $main_branch --head working_branch
   fi
   
fi

###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 ###2nd commit
##8th commit
