create view [data_out_manila_apps].[sulu_stndrd_tmsht_codes] as (
select 
code.timesheet_code as TMSHT_CODE,	
code.timesheet_code_name as TMSHT_CODE_NAME,	
proj.project_id,	
proj.name as PROJ_NAME,	
code.valid_from as VALID_FROM_DATE,	
code.valid_to as VALID_TO_DATE
from data_in.proj
join data_in.proj_tmsht_code code on proj.project_id = code.project_id
where proj.project_id in (5194,4628,4532,4622,4688,5099,5113,4984,5083,5104,4948,4923,4995,5214,4882,4997,4958,5180,5062,4965,4963,5093,5007,5202,5068,4905,4900,4890,4892,5201,4889,4893,4899,4897,5200,4937,4904,5149,4919,5217,4920,4918,4925,4926,4989,5126,5008,5125,5010,5124,4951,5213,5150,4952,5017,4959,5178,4977,4969,4933,4980,4985,4994,5019,5022,5027,5148,5181,5182,5115,5100,5103,5098,5116,5188,5189)
)
GO

