# Cheat sheet
Thank me later

## Search and replace:
Vim often assumes your last search.
1. You can do * or # to select next/prev occurrence of highlighted word 
2. Do `:%s//replacement` to replace live

Obviously you can do any sort of search. * and # is easy example

1. <leader>sg to search in git files
2. `option + q` to open search in quickfix list
3. `:cdo %s/old/new/gc | update` quickfix list with all the files that have old word, then do search and replace in each file with confirmation
