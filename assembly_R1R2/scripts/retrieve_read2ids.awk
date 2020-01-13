#! /usr/bin/gawk -f

#goal = get read ids

#required input files
# cstacks loci ids you want to keep (ie a .sel file)
# the retrieve_ustacks_ids.out file
# ustacks tags.tsv files

{
if(FILENAME==ARGV[1]){ctg_sel[$1]++}
if(FILENAME==ARGV[2]){
  if($1 in ctg_sel){sel[$2,$3]=$1}
}
if(FILENAME==ARGV[3] && FNR==1){delete(ctg_sel);FS="\t"}
if(FILENAME!=ARGV[1] && FILENAME!=ARGV[2]){
  if(FNR==1){
    dum=split(FILENAME,tmp,"/")
    dum2=split(tmp[5],toto,".tags.tsv")
    file_prefix=toto[1]
    print "working on " file_prefix
    read2_name=file_prefix".read2.lst"
    fq_2_file=file_prefix".fq_2"
    {print "/home/cruaud/programs/rad/sel_fq_2.awk",read2_name,fq_2_file > "retrieve_read2.run"}   #edit path to the sel_fq_2.awk script
  }
  if(/model/){if((FILENAME,$3) in sel){pp=1;ctg=sel[FILENAME,$3]}else{pp=0}}
  if(pp==1){
   if(/primary/){dum=$9;{print "@"substr(dum,1,length(dum)-1)"2",ctg>read2_name}}
   if(/secondary/){dum=$9;{print "@"substr(dum,1,length(dum)-1)"2",ctg>read2_name}}
    }
}


}
