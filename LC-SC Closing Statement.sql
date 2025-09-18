SELECT 
    lc.COMPANY_SHORT_NAME AS SBU,
    lb.SHORT_NAME AS BUYER,
    bb.BRAND_NAME AS BUYER_BRAND,
    csc.INTERNAL_FILE_NO AS FILE_REF, 
    cel.EXPORT_LC_NO AS LC_NUMBER, 
    csc.CONTRACT_NO AS "SC/MASTER LC NO.",
    --cel.ESTIMATED_QNTY,
    cscoi.ATTACHED_QNTY
FROM 
    WO_PO_DETAILS_MASTER wpdm
JOIN 
    WO_PO_BREAK_DOWN wpbd 
        ON wpdm.JOB_NO = wpbd.JOB_NO_MST
JOIN 
    LIB_BUYER lb 
        ON wpdm.BUYER_NAME = lb.ID
JOIN 
    LIB_COMPANY lc 
        ON wpdm.COMPANY_NAME = lc.ID
LEFT JOIN 
    LIB_BUYER_BRAND bb 
        ON wpdm.BRAND_ID = bb.ID
JOIN 
    COM_SALES_CONTRACT csc 
        ON wpdm.BUYER_NAME = csc.BUYER_NAME  
JOIN 
    COM_SALES_CONTRACT_ORDER_INFO cscoi 
        ON csc.ID = cscoi.COM_SALES_CONTRACT_ID 
       AND cscoi.WO_PO_BREAK_DOWN_ID = wpbd.ID
JOIN 
    COM_EXPORT_LC cel 
        ON csc.INTERNAL_FILE_NO = cel.INTERNAL_FILE_NO
WHERE 
    wpdm.Is_deleted = 0
    AND wpdm.status_active = 1
    AND wpbd.Is_deleted = 0
    AND wpbd.status_active = 1
GROUP BY 
    lc.COMPANY_SHORT_NAME, 
    lb.SHORT_NAME,
    bb.BRAND_NAME,
    wpdm.JOB_NO,
    csc.INTERNAL_FILE_NO,
    csc.CONTRACT_NO,  
    cel.EXPORT_LC_NO,
    cel.ESTIMATED_QNTY,
    cscoi.ATTACHED_QNTY
ORDER BY 
    wpdm.JOB_NO;
