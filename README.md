## youtrack
- Do you hate the visual mess that is the web version of youtrack?
- Do you wish it was easier to create a tech debt issue right from the line of code you're reading?
- Did a previous dev make the whole product org use Youtrack because he used Intellij, and because it was
  a cost effective option, and because it was better than just using Asana, and becuase Youtrack is way better
  than VersionOne?

If so, this is the plugin for you

### Installation

#### Packer:
```
  use {
    'trip-zip/youtrack',
    requires = {'trip-zip/plenary.nvim'} -- Just using the fork while we figure out the curl thing.
  }
```
#### Plug:
```
```
### Configuration

### Developing:
1) `git clone git@github.com:trip-zip/youtrack.git`
2) Point packer at the local directory: `  
```
use {
    '~/projects/youtrack',
    requires = {'nvim-lua/plenary.nvim'}
  }
  ```
3) Party in the USSR.
