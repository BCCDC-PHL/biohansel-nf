#!/usr/bin/env nextflow

nextflow.enable.dsl = 2

include { biohansel } from './modules/biohansel.nf'

workflow {
  ch_fastq = Channel.fromFilePairs( params.fastq_search_path, flat: true ).map{ it -> [it[0].split('_')[0], it[1], it[2]] }.unique{ it -> it[0] }

  main:
  biohansel(ch_fastq)
}