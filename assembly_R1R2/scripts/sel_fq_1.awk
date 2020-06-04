#! /usr/bin/gawk -f

#goal = retrieve reads1 in fq_1 files
#required input files :
# $sample_code.fq_1 files from 04_PUR (copy or symbolic link)
# the retrieve_read1.run file 
{
    if(FILENAME==ARGV[1]){file[$1]=$2;nreads++}else{
if(FNR==1){
    {print "read1 name list loaded for " FILENAME}
    {print nreads,"reads need to be selected"}
}
if(/^@/ && /_1$/){
    if($1 in file){
	pp=1;ff=file[$1];nread1_found++
      if(nread1_found%1000000==0){print nread1_found,"found out of",NR/4}
    }else{pp=0}
}
if(pp==1){print $1,ff,FILENAME,NR>FILENAME".sel"}
 }
}END{
    print nread1_found,"out of",nreads,":",100*nread1_found/nreads," %"
}
