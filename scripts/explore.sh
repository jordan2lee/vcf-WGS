#!/usr/bin/bash

# ### Example
# bash scripts/explore.sh src/G_H_507472.vcf vcftools/G_H_507472
# bash scripts/explore.sh src/T_H_50472.vcf vcftools/T_H_50472
# bash scripts/explore.sh src/CCDS_mutect_H_50472.merged.sorted.filtered_annotated_variants.vcf vcftools/CCDS_mutect_H_50472


# see warning for https://github.com/vcftools/vcftools/issues/134

SUBSET_VCF=${1}
OUT=${2}


# allele freq. exclude sites with more than 2 alleles
echo 'Running allele freq'
# vcftools --gzvcf $SUBSET_VCF --freq --out $OUT --max-alleles 2
vcftools --gzvcf $SUBSET_VCF --freq2 --out $OUT --max-alleles 2
# head vcftools/G_H_507472.frq

# mean depth per individual
echo 'Running mean depth per indi'
vcftools --gzvcf $SUBSET_VCF --depth --out $OUT
# head vcftools/G_H_507472.idepth

# mean depth per site
echo 'Running mean depth per site'
vcftools --gzvcf $SUBSET_VCF --site-mean-depth --out $OUT
# head vcftools/G_H_507472.ldepth.mean

# site quality
echo 'Running site qual'
vcftools --gzvcf $SUBSET_VCF --site-quality --out $OUT
# head vcftools/G_H_507472.lqual


# echo 'Running missing data per individual'
# vcftools --gzvcf $SUBSET_VCF --missing-indv --out $OUT
# # Error: Polyploidy found, and not supported by vcftools: chr11:463826
#
#
# echo 'Running missing data per site'
# vcftools --gzvcf $SUBSET_VCF --missing-site --out $OUT
# # Error: Polyploidy found, and not supported by vcftools: chr11:463826

echo 'Running heterozygosity and inbreeding coefficient per individual'
vcftools --gzvcf $SUBSET_VCF --het --out $OUT
# head vcftools/G_H_507472.het

echo 'run visuals.Rmd for figures and downstream stats'
