cat ~/task_log.txt | cut -c 23- | rev | cut -c 2- | rev | tr -s ' ' '\n'| tr -s ' ' '\n' | sort | sed 's/[^[:alpha:]]\+//' | sed 's/[^[:alpha:]]\+$//' | uniq -ic | awk '{$1=$1};1' | sort --version-sort