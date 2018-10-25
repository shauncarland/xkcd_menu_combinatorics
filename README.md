In an XKCD comic (https://www.xkcd.com/287/), a patron at a resteraunt asks to buy a total number of items on a menu that will add up to a specific price.  This Menucombinatorics module does just that.

USAGE:
To use this module, you will need a .txt file in the following format:
```
$<TOTAL_COST>
<ITEM 1>,$<PRICE 1>
<ITEM 2>,$<PRICE 2>
```
And so on and so on...

To generate the menu combinatorics, simply run:
`MenuCombinatorics.call("PATH_TO_FILE.txt")`

This will return you an array of items that, if bought together, will add up to the target price.  If there is no combination, you will receive a string indicating that.
