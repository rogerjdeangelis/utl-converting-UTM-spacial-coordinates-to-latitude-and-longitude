Converting UTM spacial coordinates to latitude and longitude                                                                   
                                                                                                                               
github                                                                                                                         
https://tinyurl.com/y2dpdho7                                                                                                   
https://github.com/rogerjdeangelis/utl-converting-UTM-spacial-coordinates-to-latitude-and-longitude                            
                                                                                                                               
SAS Forum                                                                                                                      
https://tinyurl.com/y3jlc266                                                                                                   
https://communities.sas.com/t5/SAS-Programming/Convert-UTM-to-Lat-Long-for-ED50-Zone-31N/m-p/586439                            
                                                                                                                               
Stackoverflow                                                                                                                  
https://tinyurl.com/y6fyzchw                                                                                                   
https://gis.stackexchange.com/questions/263248/error-while-converting-utm-data-to-lat-long-coordinate                          
                                                                                                                               
BG1850 Profile                                                                                                                 
https://gis.stackexchange.com/users/109988/bg1850                                                                              
                                                                                                                               
related repo                                                                                                                   
https://tinyurl.com/yyjxbnpq                                                                                                   
https://github.com/rogerjdeangelis/utl-converting-census-tracks-to-latitiudes-and-longitudes-using-R-packages                  
                                                                                                                               
*_                   _                                                                                                         
(_)_ __  _ __  _   _| |_                                                                                                       
| | '_ \| '_ \| | | | __|                                                                                                      
| | | | | |_) | |_| | |_                                                                                                       
|_|_| |_| .__/ \__,_|\__|                                                                                                      
        |_|                                                                                                                    
;                                                                                                                              
                                                                                                                               
options validvarname=upcase;                                                                                                   
libname sd1 "d:/sd1";                                                                                                          
data sd1.have;                                                                                                                 
  input X Y;                                                                                                                   
cards4;                                                                                                                        
513932.02 6266840.53                                                                                                           
514986.02 6276840.53                                                                                                           
515932.02 6286840.53                                                                                                           
;;;;                                                                                                                           
run;quit;                                                                                                                      
                                                                                                                               
I entered your input                                                                                                           
                                                                                                                               
UTM-X = 513932.02                                                                                                              
UTM-Y = 6266840.53                                                                                                             
ZONE  = 18N                                                                                                                    
                                                                                                                               
Using the online converter                                                                                                     
https://awsm-tools.com/geo/utm-to-geographic                                                                                   
                                                                                                                               
Logitude     Latitude                                                                                                          
---------    --------                                                                                                          
-74.77341    56.54570                                                                                                          
                                                                                                                               
*            _               _                                                                                                 
  ___  _   _| |_ _ __  _   _| |_                                                                                               
 / _ \| | | | __| '_ \| | | | __|                                                                                              
| (_) | |_| | |_| |_) | |_| | |_                                                                                               
 \___/ \__,_|\__| .__/ \__,_|\__|                                                                                              
                |_|                                                                                                            
;                                                                                                                              
                                                                                                                               
WORK.WANT total obs=3                                                                                                          
                                                                                                                               
 ZONE   LONG        LAT                                                                                                        
                                                                                                                               
 18N  -74.7734    56.5457 * matches online converter                                                                           
 18N  -74.7557    56.6355                                                                                                      
 18N  -74.7397    56.7253                                                                                                      
                                                                                                                               
*                                                                                                                              
 _ __  _ __ ___   ___ ___  ___ ___                                                                                             
| '_ \| '__/ _ \ / __/ _ \/ __/ __|                                                                                            
| |_) | | | (_) | (_|  __/\__ \__ \                                                                                            
| .__/|_|  \___/ \___\___||___/___/                                                                                            
|_|                                                                                                                            
;                                                                                                                              
                                                                                                                               
%utl_submit_r64('                                                                                                              
library(haven);                                                                                                                
library(sp);                                                                                                                   
library(rgdal);                                                                                                                
library(SASxport);                                                                                                             
have<-read_sas("d:/sd1/have.sas7bdat");                                                                                        
cord_transform <- function(df){                                                                                                
coordinates(df) <- ~X+Y;                                                                                                       
proj4string(df) <- "+proj=utm +zone=18N +ellps=GRS80 +units=m +no_defs";                                                       
df.lat.long <- spTransform(df,CRSobj=CRS("+proj=longlat +ellps=WGS84 +datum=WGS84 +no_defs"));                                 
want<-as.data.frame(df.lat.long);                                                                                              
str(want);                                                                                                                     
write.xport(want,file="d:/xpt/want.xpt");                                                                                      
};                                                                                                                             
cord_transform(have);                                                                                                          
');                                                                                                                            
                                                                                                                               
libname xpt xport "d:/xpt/want.xpt";                                                                                           
data want;                                                                                                                     
  retain zone "18N";                                                                                                           
  set xpt.want(rename=(x=long y=lat));                                                                                         
run;quit;                                                                                                                      
libname xpt clear;                                                                                                             
                                                                                                                               
                                                                                                                               
                                                                                                                               
                                                                                                                               
