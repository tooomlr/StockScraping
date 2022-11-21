#SECRETS TOKEN 
ID_TELEGRAM="-1001559066781"
TOKEN="5851033018:AAFCWVCnkV1hr74JoioBbsEgAhLik81oqo8"
current_hour=$(date +%m-%d-%Y-%T)
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


url='https://www.cnbc.com/quotes/FDS?qsearchterm=fds'
output=price.txt
touch $output temp.txt
curl -o $output $url 
strip_html  
print
