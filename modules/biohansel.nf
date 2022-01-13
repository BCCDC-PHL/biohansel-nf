process biohansel {

  tag { sample_id }

  publishDir "${params.outdir}/${sample_id}", pattern: "${sample_id}*.csv", mode: 'copy'

  input:
  tuple val(sample_id), path(reads_1), path(reads_2)

  output:
  tuple val(sample_id), path("${sample_id}_summary.csv")

  script:
  """
  hansel -t ${task.cpus} -s ${params.scheme} -p ${reads_1} ${reads_2} -S ${sample_id}_summary.tsv
  tr -d ',' < ${sample_id}_summary.tsv | tr \$'\\t' ',' > ${sample_id}_summary.csv
  """
}