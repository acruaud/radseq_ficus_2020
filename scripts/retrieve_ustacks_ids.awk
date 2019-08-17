#! /usr/bin/gawk -f

#goal = for a list of loci created by cstacks get corresponding ustacks ids for all samples

#required input files :
# a list of ustacks tags.tsv files +path with samples in the same order as for cstacks catalog building (should be the case if you used RADIS)
# cstacks loci ids you want to keep (ie a .sel file)
# cstacks catalog

BEGIN{OFS=ORS=""}
{
if(FILENAME==ARGV[1] && NF>0){
  nind++
  if($2*1==0){
    tag_file[nind]=$1
    split($1,dum,"\.")
    nom_ind[nind]=dum[1]
    }

 }
if(FILENAME==ARGV[2]){tag_sel[$1]++}
if(FILENAME==ARGV[3]){
  if($3 in tag_sel){
    delete(cnt)
    split($8,tmp_samp,",")
    for(i in tmp_samp){
      split(tmp_samp[i],toto,"_")
      if(toto[1] in tag_file){
        cnt[toto[1]]++
        if(cnt[toto[1]]==1){print $3," ",tag_file[toto[1]]," ",toto[2],"\n">"retrieve_ustacks_ids.out"}
     }
  }
 }
}
}
