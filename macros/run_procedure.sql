-- macros/run_proc.sql
{% macro run_procedure() %}
  {% do run_query("call `studio-de-accelerator.costco_demo_gold.sales_aggregate`();") %}
{% endmacro %}