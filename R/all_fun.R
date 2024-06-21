#' pattern_generator
#'
#' Allow to create patterns which have a part that is varying randomly each time.
#' @param base_ is the pattern that will be kept
#' @param from_ is the vector from which the elements of the random part will be generated
#' @param hmn is how many of varying pattern from the same base will be created
#' @param after is set to 1 by default, it means that the varying part will be after the fixed part, set to 0 if you want the varying part to be before 
#' @param nb is the number of random pattern chosen for the varying part
#' @param sep is the separator between all patterns in the returned value
#' @examples
#'
#'print(pattern_generator(base_="oui", from_=c("er", "re", "ere"), nb=1, hmn=3))
#'
#'# [1] "ouier" "ouire" "ouier"
#'
#'print(pattern_generator(base_="oui", from_=c("er", "re", "ere"), nb=2, hmn=3, after=0, sep="-"))
#'
#'# [1] "er-re-o-u-i"  "ere-re-o-u-i" "ere-er-o-u-i"
#'
#' @export

pattern_generator <- function(base_, from_, nb, hmn=1, after=1, sep=""){
  
  rtnl <- c()
  
  base_ <- unlist(str_split(base_, ""))
  
  base2_ <- base_
  
  for (I in 1:hmn){
    
    for (i in 1:nb){
      
      idx <- round(runif(1, 1, length(from_)), 0)
      
      if (after == 1){
        
        base_ <- append(base_, from_[idx])
        
      }else{
        
        base_ <- append(base_, from_[idx], after=0)
        
      }
      
    }
    
    base_ <- stri_paste(base_, collapse=sep)
    
    rtnl <- append(rtnl, base_)
    
    base_ <- base2_
    
  }
  
  return(rtnl)
  
}

#' data_gen
#'
#' Allo to generate in a csv all kind of data you can imagine according to what you provide
#' @param type_ is a vector. Its arguments designates a column, a column can be made of numbers ("number"), string ("string") or both ("mixed")
#' @param strt_l is a vector containing for each column the row from which the data will begin to be generated
#' @param nb_r is a vector containing for each column, the number of row full from generated data  
#' @param output is the name of the output csv file, defaults to NA so no csv will be outputed by default
#' @param type_distri is a vector which, for each column, associate a type of distribution ("random", "poisson", "gaussian"), it meas that non only the number but also the length of the string will be randomly generated according to these distribution laws
#' @param properties is linked to type_distri because it is the parameters ("min_val-max_val") for "random type", ("u-x") for the poisson distribution, ("u-d") for gaussian distribution
#' @param str_source is the source (vector) from which the character creating random string are (default set to the occidental alphabet)
#' @param round_l is a vector which, for each column containing number, associate a round value, if the type of the value is numeric
#' @param sep_ is the separator used to write data in the csv
#' @return new generated data in addition to saving it in the output
#' @examples
#' 
#' print(data_gen())
#' 
#' #  X1   X2    X3
#' #1   4    2  <NA>
#' #2   2    4  <NA>
#' #3   5    2  <NA>
#' #4   2 abcd  <NA>
#' #5   4 abcd  <NA>
#' #6   2    4  <NA>
#' #7   2  abc  <NA>
#' #8   4  abc  <NA>
#' #9   4    3  <NA>
#' #10  4  abc  abcd
#' #11  5 <NA>   abc
#' #12  4 <NA>   abc
#' #13  1 <NA>    ab
#' #14  1 <NA> abcde
#' #15  2 <NA>   abc
#' #16  4 <NA>     a
#' #17  1 <NA>  abcd
#' #18  4 <NA>    ab
#' #19  2 <NA>  abcd
#' #20  3 <NA>    ab
#' #21  3 <NA>  abcd
#' #22  2 <NA>     a
#' #23  4 <NA>   abc
#' #24  1 <NA>  abcd
#' #25  4 <NA>   abc
#' #26  4 <NA>    ab
#' #27  2 <NA>   abc
#' #28  5 <NA>    ab
#' #29  3 <NA>   abc
#' #30  5 <NA>  abcd
#' #31  2 <NA>   abc
#' #32  2 <NA>   abc
#' #33  1 <NA>    ab
#' #34  5 <NA>     a
#' #35  4 <NA>    ab
#' #36  1 <NA>    ab
#' #37  1 <NA> abcde
#' #38  5 <NA>   abc
#' #39  4 <NA>    ab
#' #40  5 <NA> abcde
#' #41  2 <NA>    ab
#' #42  3 <NA>    ab
#' #43  2 <NA>    ab
#' #44  4 <NA>  abcd
#' #45  5 <NA>  abcd
#' #46  3 <NA>  abcd
#' #47  2 <NA>  abcd
#' #48  3 <NA>  abcd
#' #49  3 <NA>  abcd
#' #50  4 <NA>     a
#'
#' print(data_gen(strt_l=c(0, 0, 0), nb_r=c(5, 5, 5)))
#' 
#' #  X1    X2   X3
#' #1  2     a  abc
#' #2  3 abcde   ab
#' #3  4 abcde    a
#' #4  1     3  abc
#' #5  3     a abcd
#' @export

data_gen <- function(type_=c("number", "mixed", "string"), strt_l=c(0, 0, 10), nb_r=c(50, 10, 40), output=NA, 
                     properties=c("1-5", "1-5", "1-5"), type_distri=c("random", "random", "random"), 
                     str_source=c("a", "b", "c", "d", "e", "f", "g", 
                                  "h", "i", "j", "k", "l", "m", 
                                  "n", "o", "p", "q", "r", "s", "t", "u", "w", "x", "y", "z"), 
                     round_l=c(0, 0, 0), sep_=","){
  
  v_get1 <- c()
  
  v_get2 <- c()
  
  delta_ <- c()
  
  for (i in 1:length(properties)){
    
    v_get1 <- append(v_get1, unlist(str_split(properties[i], "-"))[1])
    
    v_get2 <- append(v_get2, unlist(str_split(properties[i], "-"))[2])
    
    delta_ <- append(delta_, (strt_l[i] + nb_r[i]))
    
  }
  
  v_get1 <- as.numeric(v_get1)
  
  v_get2 <- as.numeric(v_get2)
  
  rtnl <- data.frame(matrix(NA, nrow=max(delta_), ncol=length(type_)))
  
  for (I in 1:length(type_)){
    
    if (type_[I] == "mixed"){
      
      for (i in strt_l[I]:(nb_r[I]+strt_l[I])){
        
        str_ <- round(runif(1, 0, 1), 0)
        
        if (str_ == 1){
          
          if (type_distri[I] == "random"){
            
            add_ <- round(runif(1, v_get1[I], v_get2[I]), 0)
            
            if (add_ > length(str_source)){
              
              add_ <- length(str_source)
              
            }
            
            rtnl[i, I] <- stri_paste(str_source[1:add_], collapse="")
            
          }
          
          if (type_distri[I] == "poisson"){
            
            add_ <- round(dpois(v_get1[I], v_get2[I]), 0)
            
            if (add_ > length(str_source)){
              
              add_ <- length(str_source)
              
            }
            
            rtnl[i, I] <- stri_paste(str_source[1:add_], collapse="")
            
          }
          
          if (type_distri[I] == "gaussian"){
            
            add_ <- round(runif(1, v_get1[I], v_get2[I]), 0)
            
            if (add_ > length(str_source)){
              
              add_ <- length(str_source)
              
            }
            
            rtnl[i, I] <- stri_paste(str_source[1:add_], collapse="")
            
          }
          
        }else{
          
          
          if (type_distri[I] == "random"){
            
            add_ <- round(runif(1, v_get1[I], v_get2[I]), round_l[I])
            
            rtnl[i, I] <- add_
            
          }
          
          if (type_distri[I] == "poisson"){
            
            add_ <- round(dpois(v_get1[I], v_get2[I]), round_l[I]) 
            
            rtnl[i, I] <- add_
            
          }
          
          if (type_distri[I] == "gaussian"){
            
            add_ <- round(dnorm(v_get1[I], v_get2[I]), round_l[I])
            
            rtnl[i, I] <- add_
            
          }
          
          
        }
        
      }
      
    }
    
    if (type_[I] == "string"){
      
      for (i in strt_l[I]:(nb_r[I]+strt_l[I])){
        
        if (type_distri[I] == "random"){
          
          add_ <- round(runif(1, v_get1[I], v_get2[I]), 0)
          
          if (add_ > length(str_source)){
            
            add_ <- length(str_source)
            
          }
          
          rtnl[i, I] <- stri_paste(str_source[1:add_], collapse="")
          
        }
        
        if (type_distri[I] == "poisson"){
          
          add_ <- round(dpois(v_get1[I], v_get2[I]), 0)
          
          if (add_ > length(str_source)){
            
            add_ <- length(str_source)
            
          }
          
          rtnl[i, I] <- stri_paste(str_source[1:add_], collapse="")
          
        }
        
        if (type_distri[I] == "gaussian"){
          
          add_ <- round(runif(1, v_get1[I], v_get2[I]), 0)
          
          if (add_ > length(str_source)){
            
            add_ <- length(str_source)
            
          }
          
          rtnl[i, I] <- stri_paste(str_source[1:add_], collapse="")
          
        }
        
      }
      
    }
    
    if (type_[I] == "number"){
      
      for (i in strt_l[I]:(nb_r[I]+strt_l[I])){
        
        if (type_distri[I] == "random"){
          
          add_ <- round(runif(1, v_get1[I], v_get2[I]), round_l[I])
          
          rtnl[i, I] <- add_
          
        }
        
        if (type_distri[I] == "poisson"){
          
          add_ <- round(dpois(v_get1[I], v_get2[I]), round_l[I]) 
          
          rtnl[i, I] <- add_
          
        }
        
        if (type_distri[I] == "gaussian"){
          
          add_ <- round(dnorm(v_get1[I], v_get2[I]), round_l[I])
          
          rtnl[i, I] <- add_
          
        }
        
      }
      
    }
    
  }
  
  if (is.na(output) == FALSE){
    
    write.table(rtnl, output, sep=sep_, row.names=FALSE, col.names=FALSE)
    
  }
  
  return(rtnl)
  
}

#' infinite_char_seq 
#'
#' Allow to generate an infinite sequence of unique letters
#'
#' @param n is how many sequence of numbers will be generated
#' @param base_char is the vector containing the elements from which the sequence is generated
#' @examples
#'
#' print(infinite_char_seq(28))
#'
#'  [1] "a"  "b"  "c"  "d"  "e"  "f"  "g"  "h"  "i"  "j"  "k"  "l"  "m"  "n"  "o" 
#' [16] "p"  "q"  "r"  "s"  "t"  "u"  "v"  "w"  "x"  "y"  "a"  "aa" "ab"
#'
#' @export

infinite_char_seq <- function(n, base_char = letters){
  Rtnl <- c()
  for (I in 1:n){
    n <- I
    rtn_v <- c()
    cnt = 0
    while (26 ** cnt <= n){
      cnt = cnt + 1
      reste <- n %% (26 ** cnt)
      if (reste != 0){
        if (reste >= 26){ reste2 <- reste / (26 ** (cnt - 1)) }else{ reste2 <- reste }
        rtn_v <- c(rtn_v, base_char[reste2])
      }else{
        reste <- 26 ** cnt
        rtn_v <- c(rtn_v, base_char[26])
      }
      n = n - reste
    }
    Rtnl <- c(Rtnl, paste(rtn_v[length(rtn_v):1], collapse = ""))
  }
  return(Rtnl)
}

#' selected_char 
#'
#' Allow to generate a char based on a conbinaison on characters from a vector and a number
#'
#' @param n is how many sequence of numbers will be generated
#' @param base_char is the vector containing the elements from which the character is generated
#' @examples
#'
#' print(selected_char(1222))
#'
#' [1] "zta"
#'
#' @export

selected_char <- function(n, base_char = letters){
  rtn_v <- c()
  cnt = 0
  while (26 ** cnt <= n){
    cnt = cnt + 1
    reste <- n %% (26 ** cnt)
    if (reste != 0){
      if (reste >= 26){ reste2 <- reste / (26 ** (cnt - 1)) }else{ reste2 <- reste }
      rtn_v <- c(rtn_v, base_char[reste2])
    }else{
      reste <- 26 ** cnt
      rtn_v <- c(rtn_v, base_char[26])
    }
    n = n - reste
  }
  return(paste(rtn_v, collapse = ""))
}


