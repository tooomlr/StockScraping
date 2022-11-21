#SECRETS TOKEN 
ID_TELEGRAM=""
TOKEN=""
current_hour=$(date +%m-%d-%Y-%T)
url='https://www.cnbc.com/quotes/FDS?qsearchterm=fds'
output=price.txt
#Function for grep and save data
function strip_html(){
  grep -oP '(?<=<span class="QuoteStrip-lastPrice").*?(?=</span>)' $output >temp.txt 
  sed -i 's/[^>]*>//g' temp.txt >$output
  sed -ni '1p' temp.txt >$output
  cp temp.txt $output
  rm temp.txt

}

#Function Print
function print(){
  while read price
  do  
      val=$price
  done <$output
   
   message="$current_hour The stock price of Factset Research Systems Inc is = $val $ "
   curl --data chat_id=$ID_TELEGRAM --data-urlencode "text= $message" "https://api.telegram.org/bot$TOKEN/sendMessage?parse_mode=HTML" 
 }

function day(){
if [ "$current_hour" == "23:59" ]
then
touch $output temp.txt
curl -o $output $url 
strip_html  
print
fi
}

while true
do
touch $output temp.txt
curl -o $output $url 
strip_html  
print
day
sleep 60
done

