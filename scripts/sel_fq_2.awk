#! /usr/bin/gawk -f

#goal = retrieve reads2 in fq_2 files
#required input files :
# $sample_code.fq_2 files from 04_PUR (copy or symbolic link)
# the retrieve_read2.run file created in the previous step 
{
    if(FILENAME==ARGV[1]){file[$1]=$2;nreads++}else{
if(FNR==1){
    {print "read2 name list loaded for " FILENAME}
    {print nreads,"reads need to be selected"}
}
if(/^@/ && /_2$/){
    if($1 in file){
        pp=1;ff=file[$1];nread2_found++
      if(nread2_found%1000000==0){print nread2_found,"found out of",NR/4}
    }else{pp=0}
}
if(pp==1){print $1,ff,FILENAME,NR>FILENAME".sel"}
 }
}END{
    print nread2_found,"out of",nreads,":",100*nread2_found/nreads," %"
}
