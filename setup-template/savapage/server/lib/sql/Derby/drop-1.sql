
    alter table tbl_account 
        drop constraint FK_ACCOUNT_TO_PARENT;

    alter table tbl_account_attr 
        drop constraint FK_ACCOUNT_ATTR_TO_ACCOUNT;

    alter table tbl_account_trx 
        drop constraint FK_ACCOUNT_TRX_TO_ACCOUNT;

    alter table tbl_account_trx 
        drop constraint FK_ACCOUNT_TRX_TO_ACCOUNT_VOUCHER;

    alter table tbl_account_trx 
        drop constraint FK_ACCOUNT_TRX_TO_DOCLOG;

    alter table tbl_account_trx 
        drop constraint FK_ACCOUNT_TRX_TO_POS_PURCHASE;

    alter table tbl_device 
        drop constraint FK_DEVICE_TERMINAL_TO_CARD_READER;

    alter table tbl_device 
        drop constraint FK_DEVICE_TO_PRINTER;

    alter table tbl_device 
        drop constraint FK_DEVICE_TO_PRINTER_GROUP;

    alter table tbl_device_attr 
        drop constraint FK_DEVICE_ATTR_TO_DEVICE;

    alter table tbl_doc_in 
        drop constraint FK_DOC_IN_TO_PRINT_IN;

    alter table tbl_doc_in_out 
        drop constraint FK_DOC_IN_OUT_TO_DOC_IN;

    alter table tbl_doc_in_out 
        drop constraint FK_DOC_IN_OUT_TO_DOC_OUT;

    alter table tbl_doc_log 
        drop constraint FK_DOC_LOG_TO_DOC_IN;

    alter table tbl_doc_log 
        drop constraint FK_DOC_LOG_TO_DOC_OUT;

    alter table tbl_doc_log 
        drop constraint FK_DOC_LOG_TO_USER;

    alter table tbl_doc_out 
        drop constraint FK_DOC_OUT_TO_PDF_OUT;

    alter table tbl_doc_out 
        drop constraint FK_DOC_OUT_TO_PRINT_OUT;

    alter table tbl_ipp_queue_attr 
        drop constraint FK_IPP_QUEUE_ATTR_TO_IPP_QUEUE;

    alter table tbl_pos_purchase_item 
        drop constraint FK_POS_PURCHASE_ITEM_TO_POS_PURCHASE;

    alter table tbl_print_in 
        drop constraint FK_PRINT_IN_TO_IPP_QUEUE;

    alter table tbl_print_out 
        drop constraint FK_PRINT_OUT_TO_PRINTER;

    alter table tbl_printer_attr 
        drop constraint FK_PRINTER_ATTR_TO_PRINTER;

    alter table tbl_printer_group_member 
        drop constraint FK_PRINTER_GROUP_MEMBER_TO_PRINTER_GROUP;

    alter table tbl_printer_group_member 
        drop constraint FK_PRINTER_GROUP_MEMBER_TO_PRINTER;

    alter table tbl_user_account 
        drop constraint FK_USER_ACCOUNT_TO_ACCOUNT;

    alter table tbl_user_account 
        drop constraint FK_USER_ACCOUNT_TO_USER;

    alter table tbl_user_attr 
        drop constraint FK_USER_ATTR_TO_USER;

    alter table tbl_user_card 
        drop constraint FK_USER_CARD_TO_USER;

    alter table tbl_user_email 
        drop constraint FK_USER_EMAIL_TO_USER;

    alter table tbl_user_group_account 
        drop constraint FK_USER_GROUP_ACCOUNT_TO_ACCOUNT;

    alter table tbl_user_group_account 
        drop constraint FK_USER_GROUP_ACCOUNT_TO_USER_GROUP;

    alter table tbl_user_group_attr 
        drop constraint FK_USER_GROUP_ATTR_TO_USER_GROUP;

    alter table tbl_user_group_member 
        drop constraint FK_USER_GROUP_MEMBER_TO_USER_GROUP;

    alter table tbl_user_group_member 
        drop constraint FK_USER_GROUP_MEMBER_TO_USER;

    alter table tbl_user_number 
        drop constraint FK_USER_NUMBER_TO_USER;

    drop table tbl_account;

    drop table tbl_account_attr;

    drop table tbl_account_trx;

    drop table tbl_account_voucher;

    drop table tbl_application_log;

    drop table tbl_config;

    drop table tbl_device;

    drop table tbl_device_attr;

    drop table tbl_doc_in;

    drop table tbl_doc_in_out;

    drop table tbl_doc_log;

    drop table tbl_doc_out;

    drop table tbl_ipp_queue;

    drop table tbl_ipp_queue_attr;

    drop table tbl_pdf_out;

    drop table tbl_pos_item;

    drop table tbl_pos_purchase;

    drop table tbl_pos_purchase_item;

    drop table tbl_print_in;

    drop table tbl_print_out;

    drop table tbl_printer;

    drop table tbl_printer_attr;

    drop table tbl_printer_group;

    drop table tbl_printer_group_member;

    drop table tbl_user;

    drop table tbl_user_account;

    drop table tbl_user_attr;

    drop table tbl_user_card;

    drop table tbl_user_email;

    drop table tbl_user_group;

    drop table tbl_user_group_account;

    drop table tbl_user_group_attr;

    drop table tbl_user_group_member;

    drop table tbl_user_number;

    drop table tbl_sequences;
