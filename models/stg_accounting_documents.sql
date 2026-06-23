{{ config(materialized='view') }}

SELECT
--header Information
    BKPF.mandt,
    BKPF.bukrs          as company_code,
    BKPF.belnr          as accounting_document_number,
    BKPF.gjahr          as fiscal_year,
    BKPF.blart          as document_type,
    BKPF.bldat          as document_date,
    BKPF.budat          as posting_date,
    BKPF.monat          as fiscal_period,
    BKPF.waers          as currency,
    BKPF.xblnr          as reference_document_number,
    BKPF.bktxt          as document_header_text,

--Line Item Information
    BSEG.buzei         as line_item_number,
    BSEG.koart         as account_type,
    BSEG.hkont         as gl_account,
    BSEG.kostl         as cost_center,
    BSEG.dmbtr         as local_currewncy_amount,
    BSEG.wrbtr         as document_currency_amount,
    BSEG.shkzg         as debit_credit_indicator,
    BSEG.sgtxt         as item_text,
    BSEG.lifnr         as vendor_line_item_number

from {{ source('raw_sap', 'BKPF') }} BKPF

inner join {{ source('raw_sap','BSEG') }} BSEG
    on   BKPF.mandt       = BSEG.mandt
    and  BKPF.bukrs       = BSEG.bukrs
    and  BKPF.belnr       = BSEG.belnr
    and  BKPF.gjahr       = BSEG.gjahr
