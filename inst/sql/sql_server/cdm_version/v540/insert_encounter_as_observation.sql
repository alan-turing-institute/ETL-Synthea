insert into v3_omop.observation (
observation_id,
person_id,
observation_concept_id,
observation_date,
observation_datetime,
observation_type_concept_id,
value_as_number,
value_as_string,
value_as_concept_id,
qualifier_concept_id,
unit_concept_id,
provider_id,
visit_occurrence_id,
visit_detail_id,
observation_source_value,
observation_source_concept_id,
unit_source_value,
qualifier_source_value,
value_source_value,
observation_event_id,
obs_event_field_concept_id
)

select row_number()over(order by person_id) observation_id,
person_id,
observation_concept_id,
observation_date,
observation_datetime,
observation_type_concept_id,
value_as_number,
value_as_string,
value_as_concept_id,
qualifier_concept_id,
unit_concept_id,
provider_id,
visit_occurrence_id,
visit_detail_id,
observation_source_value,
observation_source_concept_id,
unit_source_value,
qualifier_source_value,
value_source_value,
observation_event_id,
obs_event_field_concept_id
from (
select
p.person_id                                 person_id,
srctostdvm.target_concept_id                observation_concept_id,
a.start                                     observation_date,
a.start                                     observation_datetime,
38000280                                    observation_type_concept_id,
cast(null as float)                         value_as_number,
cast(null as varchar)                       value_as_string,
0                                           value_as_concept_id,
0                                           qualifier_concept_id,
0                                           unit_concept_id,
pr.provider_id                              provider_id,
fv.visit_occurrence_id_new                  visit_occurrence_id,
fv.visit_occurrence_id_new + 1000000        visit_detail_id,
a.code                                      observation_source_value,
srctosrcvm.source_concept_id                observation_source_concept_id,
cast(null as varchar)                       unit_source_value,
cast(null as varchar)                       qualifier_source_value,
cast(null as varchar)                       value_source_value,
cast(null as bigint)                        observation_event_id,
cast(null as int)                           obs_event_field_concept_id
from native.allergies a
join v3_omop.source_to_standard_vocab_map srctostdvm
  on srctostdvm.source_code             = a.code
 and srctostdvm.target_domain_id        = 'Observation'
 and srctostdvm.target_vocabulary_id    = 'SNOMED'
 and srctostdvm.target_standard_concept = 'S'
 and srctostdvm.target_invalid_reason is null
join v3_omop.source_to_source_vocab_map srctosrcvm
  on srctosrcvm.source_code             = a.code
 and srctosrcvm.source_vocabulary_id    = 'SNOMED'
 and srctosrcvm.source_domain_id        = 'Observation'
left join v3_omop.final_visit_ids fv
  on fv.encounter_id                    = a.encounter
left join native.encounters e
  on a.encounter                        = e.id
 and a.patient                          = e.patient
left join v3_omop.provider pr 
  on e.provider                         = pr.provider_source_value
join v3_omop.person p
  on p.person_source_value              = a.patient

union all

select
p.person_id                                person_id,
srctostdvm.target_concept_id               observation_concept_id,
c.start                                    observation_date,
c.start                                    observation_datetime,
38000280                                   observation_type_concept_id,
cast(null as float)                        value_as_number,
cast(null as varchar)                      value_as_string,
0                                          value_as_concept_id,
0                                          qualifier_concept_id,
0                                          unit_concept_id,
pr.provider_id                             provider_id,
fv.visit_occurrence_id_new                 visit_occurrence_id,
fv.visit_occurrence_id_new + 1000000       visit_detail_id,
c.code                                     observation_source_value,
srctosrcvm.source_concept_id               observation_source_concept_id,
cast(null as varchar)                      unit_source_value,
cast(null as varchar)                      qualifier_source_value,
cast(null as varchar)                      value_source_value,
cast(null as bigint)                       observation_event_id,
cast(null as int)                          obs_event_field_concept_id

from native.conditions c
join v3_omop.source_to_standard_vocab_map srctostdvm
  on srctostdvm.source_code             = c.code
 and srctostdvm.target_domain_id        = 'Observation'
 and srctostdvm.target_vocabulary_id    = 'SNOMED'
 and srctostdvm.target_standard_concept = 'S'
 and srctostdvm.target_invalid_reason is null
join v3_omop.source_to_source_vocab_map srctosrcvm
  on srctosrcvm.source_code              = c.code
 and srctosrcvm.source_vocabulary_id     = 'SNOMED'
 and srctosrcvm.source_domain_id         = 'Observation'
left join v3_omop.final_visit_ids fv
  on fv.encounter_id                     = c.encounter
left join native.encounters e
  on c.encounter                         = e.id
 and c.patient                           = e.patient
left join v3_omop.provider pr 
  on e.provider                          = pr.provider_source_value
join v3_omop.person p
  on p.person_source_value               = c.patient
  
union all

select
p.person_id                                person_id,
srctostdvm.target_concept_id               observation_concept_id,
o.date                                     observation_date,
o.date                                     observation_datetime,
38000280                                   observation_type_concept_id,
cast(null as float)                        value_as_number,
cast(null as varchar)                      value_as_string,
0                                          value_as_concept_id,
0                                          qualifier_concept_id,
0                                          unit_concept_id,
pr.provider_id                             provider_id,
fv.visit_occurrence_id_new                 visit_occurrence_id,
fv.visit_occurrence_id_new + 1000000       visit_detail_id,
o.code                                     observation_source_value,
srctosrcvm.source_concept_id               observation_source_concept_id,
cast(null as varchar)                      unit_source_value,
cast(null as varchar)                      qualifier_source_value,
cast(null as varchar)                      value_source_value,
cast(null as bigint)                       observation_event_id,
cast(null as int)                          obs_event_field_concept_id

from native.observations o
join v3_omop.source_to_standard_vocab_map srctostdvm
  on srctostdvm.source_code             = o.code
 and srctostdvm.target_domain_id        = 'Observation'
 and srctostdvm.target_vocabulary_id    = 'LOINC'
 and srctostdvm.target_standard_concept = 'S'
 and srctostdvm.target_invalid_reason is null
join v3_omop.source_to_source_vocab_map srctosrcvm
  on srctosrcvm.source_code              = o.code
 and srctosrcvm.source_vocabulary_id     = 'LOINC'
 and srctosrcvm.source_domain_id         = 'Observation'
left join v3_omop.final_visit_ids fv
  on fv.encounter_id                     = o.encounter
left join native.encounters e
  on o.encounter                         = e.id
 and o.patient                           = e.patient
left join v3_omop.provider pr 
  on e.provider                          = pr.provider_source_value
join v3_omop.person p
  on p.person_source_value               = o.patient

union all

select
p.person_id                                person_id,
srctostdvm.target_concept_id               observation_concept_id,
o.date                                     observation_date,
o.date                                     observation_datetime,
38000280                                   observation_type_concept_id,
cast(null as float)                        value_as_number,
cast(null as varchar)                      value_as_string,
0                                          value_as_concept_id,
0                                          qualifier_concept_id,
0                                          unit_concept_id,
pr.provider_id                             provider_id,
fv.visit_occurrence_id_new                 visit_occurrence_id,
fv.visit_occurrence_id_new + 1000000       visit_detail_id,
o.code                                     observation_source_value,
srctosrcvm.source_concept_id               observation_source_concept_id,
cast(null as varchar)                      unit_source_value,
cast(null as varchar)                      qualifier_source_value,
cast(null as varchar)                      value_source_value,
cast(null as bigint)                       observation_event_id,
cast(null as int)                          obs_event_field_concept_id

from native.observations o
join v3_omop.source_to_standard_vocab_map srctostdvm
  on srctostdvm.source_code             = o.code
 and srctostdvm.target_domain_id        = 'Observation'
 and srctostdvm.target_vocabulary_id    = 'SNOMED'
 and srctostdvm.target_standard_concept = 'S'
 and srctostdvm.target_invalid_reason is null
join v3_omop.source_to_source_vocab_map srctosrcvm
  on srctosrcvm.source_code              = o.code
 and srctosrcvm.source_vocabulary_id     = 'SNOMED'
 and srctosrcvm.source_domain_id         = 'Observation'
left join v3_omop.final_visit_ids fv
  on fv.encounter_id                     = o.encounter
left join native.encounters e
  on o.encounter                         = e.id
 and o.patient                           = e.patient
left join v3_omop.provider pr 
  on e.provider                          = pr.provider_source_value
join v3_omop.person p
  on p.person_source_value               = o.patient

union all
	
select
p.person_id                                person_id,
srctostdvm.target_concept_id               observation_concept_id,
encounter.start                                    observation_date,
encounter.start                                    observation_datetime,
38000280                                   observation_type_concept_id,
cast(null as float)                        value_as_number,
cast(null as varchar)                      value_as_string,
0                                          value_as_concept_id,
0                                          qualifier_concept_id,
0                                          unit_concept_id,
pr.provider_id                             provider_id,
fv.visit_occurrence_id_new                 visit_occurrence_id,
fv.visit_occurrence_id_new + 1000000       visit_detail_id,
encounter.code                                     observation_source_value,
srctosrcvm.source_concept_id               observation_source_concept_id,
cast(null as varchar)                      unit_source_value,
cast(null as varchar)                      qualifier_source_value,
cast(null as varchar)                      value_source_value,
cast(null as bigint)                       observation_event_id,
cast(null as int)                          obs_event_field_concept_id
from native.encounters encounter
join v3_omop.source_to_standard_vocab_map srctostdvm
  on srctostdvm.source_code             = encounter.code
 and srctostdvm.target_domain_id        = 'Observation'
 and srctostdvm.target_vocabulary_id    = 'SNOMED'
 and srctostdvm.target_standard_concept = 'S'
 and srctostdvm.target_invalid_reason is null
join v3_omop.source_to_source_vocab_map srctosrcvm
  on srctosrcvm.source_code              = encounter.code
 and srctosrcvm.source_vocabulary_id     = 'SNOMED'
 and srctosrcvm.source_domain_id         = 'Observation'
 and srctosrcvm.source_concept_class_id  = 'Procedure'
left join v3_omop.final_visit_ids fv
  on fv.encounter_id                     = encounter.id
left join v3_omop.provider pr 
  on encounter.provider                          = pr.provider_source_value
join v3_omop.person p
  on p.person_source_value               = encounter.patient
	) tmp;