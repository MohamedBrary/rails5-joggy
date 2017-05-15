```
rails g react:component RunsMain runs:array current_user:object can_change_owner:bool users:array filter_from:date filter_to:date current_week_stats:object prev_week_stats:object total_stats:object desc_head:string desc_filter:string

rails g react:component RunsForm run:object current_user:object can_change_owner:bool users:array


rails g react:component RunsStats current_week_stats:object prev_week_stats:object total_stats:object

rails g react:component RunsIndex runs:array filter_from:date filter_to:date desc_head:string desc_filter:string

rails g react:component RunsIndexFilter filter_from:date filter_to:date desc_head:string desc_filter:string

rails g react:component RunsIndexTable runs:array

rails g react:component RunsIndexTableRow run:object
```