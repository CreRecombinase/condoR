# condoR
When your data is really really wide

It's really easy to install `condoR`
in R:

```
install.packages("devtools")
devtools::install_github("CreRecombinase/condoR")
library(condoR)
```

and you're ready to go!

The idea of the package is to take data that's kinda like this

|Latitude|Longitude|Day|BIG_BIRD|LITTLE_BIRD|MEDIUM_BIRD| FREE_BIRD      |
|--------|---------|---|--------|-----------|-----------|----------------|
| 10     |    11   |  M|   1    | 0         |   1       |     0          |
| 10     |   11    | T |   0    |  2        |   0       |     0          |
|  12    |   14    | M |   0    |  0        |   0       |     0          |


And turn it in to something like this: 


|Latitude|Longitude|Day|Bird    | Count     |
|--------|---------|---|--------|-----------|
| 10     |    11   |  M|   BIG  | 1         |
| 10     |    11   |  M|  MEDIUM| 1         |
| 10     |   11    | T | LITTLE |  2        |
