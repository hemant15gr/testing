working_branch=$1
main_branch=$2
commit_id=$3
git_url=https://github.com/andromeda360/a360-flux.git
status=$(kubectl get pods --all-namespaces | grep 'a360\|auth\|istio-system' | grep -v 'auth-jwt' | grep -v 'Running' | wc -l)
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
   git revert -n $commit_id
   git commit -m "
   git push --set-upstream origin $working_branch
   git request-pull $commit_id $git_url $main_branch
   fi
   
fi

###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 ###2nd commit

##dev 1st commit ##total 3rd commit


 
