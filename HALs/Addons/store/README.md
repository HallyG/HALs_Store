# HALs Store


## Maintainers
The people responsible for merging changes to this component or answering potential questions.
* [HallyG](https://github.com/HallyG) (Author)

## Installation
### Manually
1. Create a folder in your mission root folder and name it "HALs". Then create another folder, inside of the "HALs" folder, and call it "Addons".
2. Download the contents of this repository's folder and place the "Store" folder into the directory you just created.
3. Add the following to your `description.ext`:

        class cfgFunctions {
	        #include "HALs\Addons\Store\Functions.cpp"
        };
