
    create table tbl_account (
        account_id bigint not null,
        account_type varchar(10) not null,
        balance numeric(16,6) not null,
        comments varchar(20) not null,
        created_by varchar(50) not null,
        created_date timestamp not null,
        deleted boolean not null,
        deleted_date timestamp,
        disabled boolean not null,
        disabled_until timestamp,
        invoicing varchar(20) not null,
        modified_by varchar(50),
        modified_date timestamp,
        account_name varchar(255) not null,
        account_name_lower varchar(255) not null,
        notes varchar(2000),
        overdraft numeric(16,6) not null,
        pin varchar(50),
        restricted boolean not null,
        sub_name varchar(255),
        sub_name_lower varchar(255),
        sub_pin varchar(50),
        use_global_overdraft boolean not null,
        parent_id bigint,
        primary key (account_id)
    );

    create table tbl_account_attr (
        account_attr_id bigint not null,
        attrib_name varchar(255) not null,
        attrib_value varchar(2000),
        account_id bigint not null,
        primary key (account_attr_id)
    );

    create table tbl_account_trx (
        account_trx_id bigint not null,
        amount numeric(16,6) not null,
        balance numeric(16,6) not null,
        trx_comment varchar(255),
        currency_code varchar(3),
        ext_amount numeric(16,8),
        ext_confirmations integer,
        ext_currency_code varchar(3),
        ext_details varchar(2000),
        ext_exchange_rate numeric(16,8),
        ext_fee numeric(16,8),
        ext_id varchar(128),
        ext_method varchar(20),
        ext_method_address varchar(128),
        ext_method_other varchar(32),
        ext_source varchar(32),
        is_credit boolean not null,
        trx_by varchar(50) not null,
        trx_date timestamp not null,
        trx_weight integer not null,
        trx_type varchar(20) not null,
        account_id bigint not null,
        account_voucher_id bigint,
        doc_id bigint,
        pos_purchase_id bigint,
        primary key (account_trx_id)
    );

    create table tbl_account_voucher (
        account_voucher_id bigint not null,
        card_number varchar(128) not null,
        card_number_batch varchar(64),
        created_date timestamp not null,
        currency_code varchar(3),
        expiry_date timestamp,
        issued_date timestamp,
        redeemed_date timestamp,
        trx_acquirer_code varchar(32),
        trx_amount numeric(6,2),
        trx_consumer_email varchar(255),
        trx_merchant_code varchar(32),
        trx_ref_acquirer varchar(64),
        trx_ref_merchant varchar(64),
        trx_time_merchant bigint,
        trx_time_request bigint,
        uuid varchar(64) not null,
        value_amount numeric(6,2) not null,
        voucher_type varchar(16) not null,
        primary key (account_voucher_id)
    );

    create table tbl_application_log (
        application_log_id bigint not null,
        log_date timestamp not null,
        log_level varchar(20) not null,
        message varchar(2000) not null,
        primary key (application_log_id)
    );

    create table tbl_config (
        config_id bigint not null,
        created_by varchar(50) not null,
        created_date timestamp not null,
        modified_by varchar(50) not null,
        modified_date timestamp not null,
        property_name varchar(100) not null,
        property_value varchar(1000),
        primary key (config_id)
    );

    create table tbl_device (
        device_id bigint not null,
        created_by varchar(50) not null,
        created_date timestamp not null,
        device_function varchar(32),
        device_name varchar(255) not null,
        device_type varchar(32) not null,
        disabled boolean not null,
        display_name varchar(255) not null,
        hostname varchar(45) not null,
        last_usage_date timestamp,
        location varchar(255),
        modified_by varchar(50),
        modified_date timestamp,
        notes varchar(2000),
        port integer,
        card_reader_id bigint,
        printer_id bigint,
        printer_group_id bigint,
        primary key (device_id)
    );

    create table tbl_device_attr (
        device_attr_id bigint not null,
        attrib_name varchar(255) not null,
        attrib_value varchar(2000),
        device_id bigint not null,
        primary key (device_attr_id)
    );

    create table tbl_doc_in (
        doc_in_id bigint not null,
        originator_ip varchar(45),
        print_in_id bigint,
        primary key (doc_in_id)
    );

    create table tbl_doc_in_out (
        doc_in_out_id bigint not null,
        total_pages integer,
        doc_in_id bigint not null,
        doc_out_id bigint not null,
        primary key (doc_in_out_id)
    );

    create table tbl_doc_log (
        doc_id bigint not null,
        cost numeric(10,6) not null,
        cost_original numeric(10,6) not null,
        created_date timestamp not null,
        created_day timestamp not null,
        protocol varchar(16) not null,
        drm_restricted boolean not null,
        ext_data varchar(2000),
        ext_id varchar(64),
        ext_status varchar(16),
        ext_supplier varchar(16),
        invoiced boolean not null,
        log_comment varchar(255),
        mimetype varchar(255),
        size_bytes bigint not null,
        total_pages integer,
        refunded boolean not null,
        title varchar(255),
        uuid varchar(64) not null,
        doc_in_id bigint,
        doc_out_id bigint,
        user_id bigint not null,
        primary key (doc_id)
    );

    create table tbl_doc_out (
        doc_out_id bigint not null,
        destination varchar(255),
        letterhead boolean,
        signature varchar(50) not null,
        pdf_out_id bigint,
        print_out_id bigint,
        primary key (doc_out_id)
    );

    create table tbl_ipp_queue (
        queue_id bigint not null,
        created_by varchar(50) not null,
        created_date timestamp not null,
        deleted boolean not null,
        deleted_date timestamp,
        disabled boolean not null,
        disabled_date timestamp,
        ip_allowed varchar(255),
        last_usage_date timestamp,
        lpd_enabled boolean not null,
        modified_by varchar(50),
        modified_date timestamp,
        reset_by varchar(50),
        reset_date timestamp,
        total_bytes bigint not null,
        total_jobs integer not null,
        total_pages integer not null,
        trusted boolean not null,
        url_path varchar(255) not null,
        primary key (queue_id)
    );

    create table tbl_ipp_queue_attr (
        queue_attr_id bigint not null,
        attrib_name varchar(255) not null,
        attrib_value varchar(2000),
        queue_id bigint not null,
        primary key (queue_attr_id)
    );

    create table tbl_pdf_out (
        pdf_out_id bigint not null,
        author varchar(255),
        encrypted boolean not null,
        keywords varchar(255),
        password_owner varchar(255),
        password_user varchar(255),
        subject varchar(255),
        primary key (pdf_out_id)
    );

    create table tbl_pos_item (
        pos_item_id bigint not null,
        item_cost numeric(6,2) not null,
        item_name varchar(255) not null,
        primary key (pos_item_id)
    );

    create table tbl_pos_purchase (
        pos_purchase_id bigint not null,
        comment varchar(255),
        payment_type varchar(50),
        receipt_num varchar(255) not null,
        total_cost numeric(8,2) not null,
        primary key (pos_purchase_id)
    );

    create table tbl_pos_purchase_item (
        pos_purchase_item_id bigint not null,
        item_index integer not null,
        item_name varchar(255) not null,
        item_quantity integer not null,
        item_unit_cost numeric(6,2) not null,
        pos_purchase_id bigint not null,
        primary key (pos_purchase_item_id)
    );

    create table tbl_print_in (
        print_in_id bigint not null,
        denied_reason varchar(30),
        paper_height_mm integer,
        paper_size varchar(20),
        paper_width_mm integer,
        printed boolean not null,
        queue_id bigint not null,
        primary key (print_in_id)
    );

    create table tbl_print_out (
        print_out_id bigint not null,
        color_pages_estimated boolean not null,
        color_pages_total integer not null,
        cups_completed_time integer,
        cups_creation_time integer not null,
        cups_job_id integer not null,
        cups_job_sheets varchar(128) not null,
        cups_job_state integer not null,
        cups_number_up varchar(1) not null,
        cups_page_set varchar(8) not null,
        duplex boolean not null,
        grayscale boolean not null,
        copies integer not null,
        total_esu bigint not null,
        total_sheets integer not null,
        paper_height_mm integer,
        paper_size varchar(20),
        paper_width_mm integer,
        print_mode varchar(8) not null,
        printer_id bigint not null,
        primary key (print_out_id)
    );

    create table tbl_printer (
        printer_id bigint not null,
        charge_type varchar(20) not null,
        color_detection_mode varchar(20) not null,
        created_by varchar(50) not null,
        created_date timestamp not null,
        default_cost numeric(10,6) not null,
        deleted boolean not null,
        deleted_date timestamp,
        disabled boolean not null,
        disabled_date timestamp,
        display_name varchar(255) not null,
        last_usage_date timestamp,
        location varchar(255),
        modified_by varchar(50),
        modified_date timestamp,
        notes varchar(2000),
        printer_name varchar(255) not null,
        reset_by varchar(50),
        reset_date timestamp,
        server_name varchar(255),
        total_bytes bigint not null,
        total_esu bigint not null,
        total_jobs integer not null,
        total_pages integer not null,
        total_sheets integer not null,
        primary key (printer_id)
    );

    create table tbl_printer_attr (
        printer_attr_id bigint not null,
        attrib_name varchar(255) not null,
        attrib_value varchar(2000),
        printer_id bigint not null,
        primary key (printer_attr_id)
    );

    create table tbl_printer_group (
        printer_group_id bigint not null,
        created_by varchar(50) not null,
        created_date timestamp not null,
        display_name varchar(255) not null,
        group_name varchar(255) not null,
        modified_by varchar(50),
        modified_date timestamp,
        primary key (printer_group_id)
    );

    create table tbl_printer_group_member (
        printer_group_member_id bigint not null,
        created_by varchar(50) not null,
        created_date timestamp not null,
        modified_by varchar(50),
        modified_date timestamp,
        printer_group_id bigint not null,
        printer_id bigint not null,
        primary key (printer_group_member_id)
    );

    create table tbl_user (
        user_id bigint not null,
        admin boolean not null,
        created_by varchar(50) not null,
        created_date timestamp not null,
        deleted boolean not null,
        deleted_date timestamp,
        department varchar(200),
        disabled_pdf_out boolean not null,
        disabled_pdf_out_until timestamp,
        disabled_print_in boolean not null,
        disabled_print_in_until timestamp,
        disabled_print_out boolean not null,
        disabled_print_out_until timestamp,
        external_user_name varchar(255) not null,
        full_name varchar(255),
        internal boolean not null,
        last_user_activity timestamp,
        modified_by varchar(50),
        modified_date timestamp,
        total_pdf_out_bytes bigint not null,
        total_pdf_out_jobs integer not null,
        total_pdf_out_pages integer not null,
        total_print_in_bytes bigint not null,
        total_print_in_jobs integer not null,
        total_print_in_pages integer not null,
        total_print_out_bytes bigint not null,
        total_print_out_esu bigint not null,
        total_print_out_jobs integer not null,
        total_print_out_pages integer not null,
        total_print_out_sheets integer not null,
        office varchar(200),
        person boolean not null,
        reset_by varchar(50),
        reset_date timestamp,
        user_name varchar(50) not null,
        primary key (user_id)
    );

    create table tbl_user_account (
        user_account_id bigint not null,
        created_by varchar(50) not null,
        created_date timestamp not null,
        modified_by varchar(50),
        modified_date timestamp,
        account_id bigint not null,
        user_id bigint not null,
        primary key (user_account_id)
    );

    create table tbl_user_attr (
        user_attr_id bigint not null,
        attrib_name varchar(255) not null,
        attrib_value varchar(2000),
        user_id bigint not null,
        primary key (user_attr_id)
    );

    create table tbl_user_card (
        user_card_id bigint not null,
        index_number integer not null,
        card_name varchar(255),
        card_number varchar(100) not null,
        user_id bigint not null,
        primary key (user_card_id)
    );

    create table tbl_user_email (
        user_email_id bigint not null,
        address varchar(255) not null,
        display_name varchar(255),
        index_number integer not null,
        user_id bigint not null,
        primary key (user_email_id)
    );

    create table tbl_user_group (
        user_group_id bigint not null,
        allow_accum boolean not null,
        created_by varchar(50) not null,
        created_date timestamp not null,
        group_name varchar(255) not null,
        initial_credit numeric(8,2) not null,
        initial_overdraft numeric(16,6) not null,
        initial_settings_enabled boolean not null,
        initial_use_global_overdraft boolean not null,
        initially_restricted boolean not null,
        max_accum_balance numeric(8,2) not null,
        modified_by varchar(50),
        modified_date timestamp,
        reset_statistics boolean not null,
        schedule_amount numeric(8,2) not null,
        schedule_period varchar(10) not null,
        primary key (user_group_id)
    );

    create table tbl_user_group_attr (
        user_group_attr_id bigint not null,
        attrib_name varchar(255) not null,
        attrib_value varchar(2000),
        user_group_id bigint not null,
        primary key (user_group_attr_id)
    );

    create table tbl_user_group_member (
        user_group_member_id bigint not null,
        created_by varchar(50) not null,
        created_date timestamp not null,
        modified_by varchar(50),
        modified_date timestamp,
        user_group_id bigint not null,
        user_id bigint not null,
        primary key (user_group_member_id)
    );

    create table tbl_user_number (
        user_number_id bigint not null,
        index_number integer not null,
        id_name varchar(255),
        id_number varchar(32) not null,
        user_id bigint not null,
        primary key (user_number_id)
    );

    create index ix_account_1 on tbl_account (pin, sub_pin);

    create index ix_account_2 on tbl_account (parent_id);

    create index ix_account_3 on tbl_account (account_type, account_name_lower, sub_name_lower);

    create unique index uc_account_attr_1 on tbl_account_attr (account_id, attrib_name);

    create index ix_account_trx_1 on tbl_account_trx (account_id);

    create index ix_account_trx_2 on tbl_account_trx (doc_id);

    create index ix_account_trx_3 on tbl_account_trx (trx_date);

    create index ix_account_trx_4 on tbl_account_trx (account_voucher_id);

    create index ix_account_trx_5 on tbl_account_trx (ext_id);

    create unique index uc_account_voucher_1 on tbl_account_voucher (uuid);

    create unique index uc_account_voucher_2 on tbl_account_voucher (card_number);

    create index ix_account_voucher_1 on tbl_account_voucher (card_number_batch);

    create index ix_account_voucher_2 on tbl_account_voucher (trx_merchant_code, trx_ref_merchant);

    create index ix_account_voucher_3 on tbl_account_voucher (trx_acquirer_code, trx_ref_acquirer);

    create index ix_application_log_1 on tbl_application_log (log_date);

    create unique index uc_config_1 on tbl_config (property_name);

    create index ix_config_1 on tbl_config (modified_by, modified_date);

    create unique index uc_device_1 on tbl_device (device_name);

    create unique index uc_device_2 on tbl_device (hostname, device_type);

    create unique index uc_device_attr_1 on tbl_device_attr (device_id, attrib_name);

    create index ix_doc_log_1 on tbl_doc_log (user_id, uuid);

    create index ix_doc_log_2 on tbl_doc_log (ext_supplier, ext_status);

    create unique index uc_ipp_queue_1 on tbl_ipp_queue (url_path);

    create unique index uc_queue_attr_1 on tbl_ipp_queue_attr (queue_id, attrib_name);

    create unique index uc_pos_item_1 on tbl_pos_item (item_name);

    create unique index uc_pos_purchase_1 on tbl_pos_purchase (receipt_num);

    create index ix_print_out_1 on tbl_print_out (cups_job_id);

    create unique index uc_printer_1 on tbl_printer (printer_name);

    create unique index uc_printer_attr_1 on tbl_printer_attr (printer_id, attrib_name);

    create unique index uc_printer_group_1 on tbl_printer_group (group_name);

    create unique index uc_printer_group_2 on tbl_printer_group (display_name);

    create index ix_printer_group_member_1 on tbl_printer_group_member (printer_id);

    create index ix_printer_group_member_2 on tbl_printer_group_member (printer_group_id);

    create index ix_user_1 on tbl_user (user_name);

    create index ix_user_account_1 on tbl_user_account (user_id);

    create index ix_user_account_2 on tbl_user_account (account_id);

    create unique index uc_user_attr_1 on tbl_user_attr (user_id, attrib_name);

    create unique index uc_user_card_1 on tbl_user_card (card_number);

    create unique index uc_user_card_2 on tbl_user_card (user_id, index_number);

    create index ix_user_card_1 on tbl_user_card (user_id, card_number);

    create unique index uc_user_email_1 on tbl_user_email (address);

    create unique index uc_user_email_2 on tbl_user_email (user_id, index_number);

    create index ix_user_email_1 on tbl_user_email (user_id, address);

    create unique index uc_user_group_1 on tbl_user_group (group_name);

    create unique index uc_user_group_attr_1 on tbl_user_group_attr (user_group_id, attrib_name);

    create index ix_user_group_member_1 on tbl_user_group_member (user_id);

    create index ix_user_group_member_2 on tbl_user_group_member (user_group_id);

    create unique index uc_user_number_1 on tbl_user_number (id_number);

    create unique index uc_user_number_2 on tbl_user_number (user_id, index_number);

    create index ix_user_number_1 on tbl_user_number (user_id, id_number);

    alter table tbl_account 
        add constraint FK_ACCOUNT_TO_PARENT 
        foreign key (parent_id) 
        references tbl_account;

    alter table tbl_account_attr 
        add constraint FK_ACCOUNT_ATTR_TO_ACCOUNT 
        foreign key (account_id) 
        references tbl_account;

    alter table tbl_account_trx 
        add constraint FK_ACCOUNT_TRX_TO_ACCOUNT 
        foreign key (account_id) 
        references tbl_account;

    alter table tbl_account_trx 
        add constraint FK_ACCOUNT_TRX_TO_ACCOUNT_VOUCHER 
        foreign key (account_voucher_id) 
        references tbl_account_voucher;

    alter table tbl_account_trx 
        add constraint FK_ACCOUNT_TRX_TO_DOCLOG 
        foreign key (doc_id) 
        references tbl_doc_log;

    alter table tbl_account_trx 
        add constraint FK_ACCOUNT_TRX_TO_POS_PURCHASE 
        foreign key (pos_purchase_id) 
        references tbl_pos_purchase;

    alter table tbl_device 
        add constraint FK_DEVICE_TERMINAL_TO_CARD_READER 
        foreign key (card_reader_id) 
        references tbl_device;

    alter table tbl_device 
        add constraint FK_DEVICE_TO_PRINTER 
        foreign key (printer_id) 
        references tbl_printer;

    alter table tbl_device 
        add constraint FK_DEVICE_TO_PRINTER_GROUP 
        foreign key (printer_group_id) 
        references tbl_printer_group;

    alter table tbl_device_attr 
        add constraint FK_DEVICE_ATTR_TO_DEVICE 
        foreign key (device_id) 
        references tbl_device;

    alter table tbl_doc_in 
        add constraint FK_DOC_IN_TO_PRINT_IN 
        foreign key (print_in_id) 
        references tbl_print_in;

    alter table tbl_doc_in_out 
        add constraint FK_DOC_IN_OUT_TO_DOC_IN 
        foreign key (doc_in_id) 
        references tbl_doc_in;

    alter table tbl_doc_in_out 
        add constraint FK_DOC_IN_OUT_TO_DOC_OUT 
        foreign key (doc_out_id) 
        references tbl_doc_out;

    alter table tbl_doc_log 
        add constraint FK_DOC_LOG_TO_DOC_IN 
        foreign key (doc_in_id) 
        references tbl_doc_in;

    alter table tbl_doc_log 
        add constraint FK_DOC_LOG_TO_DOC_OUT 
        foreign key (doc_out_id) 
        references tbl_doc_out;

    alter table tbl_doc_log 
        add constraint FK_DOC_LOG_TO_USER 
        foreign key (user_id) 
        references tbl_user;

    alter table tbl_doc_out 
        add constraint FK_DOC_OUT_TO_PDF_OUT 
        foreign key (pdf_out_id) 
        references tbl_pdf_out;

    alter table tbl_doc_out 
        add constraint FK_DOC_OUT_TO_PRINT_OUT 
        foreign key (print_out_id) 
        references tbl_print_out;

    alter table tbl_ipp_queue_attr 
        add constraint FK_IPP_QUEUE_ATTR_TO_IPP_QUEUE 
        foreign key (queue_id) 
        references tbl_ipp_queue;

    alter table tbl_pos_purchase_item 
        add constraint FK_POS_PURCHASE_ITEM_TO_POS_PURCHASE 
        foreign key (pos_purchase_id) 
        references tbl_pos_purchase;

    alter table tbl_print_in 
        add constraint FK_PRINT_IN_TO_IPP_QUEUE 
        foreign key (queue_id) 
        references tbl_ipp_queue;

    alter table tbl_print_out 
        add constraint FK_PRINT_OUT_TO_PRINTER 
        foreign key (printer_id) 
        references tbl_printer;

    alter table tbl_printer_attr 
        add constraint FK_PRINTER_ATTR_TO_PRINTER 
        foreign key (printer_id) 
        references tbl_printer;

    alter table tbl_printer_group_member 
        add constraint FK_PRINTER_GROUP_MEMBER_TO_PRINTER_GROUP 
        foreign key (printer_group_id) 
        references tbl_printer_group;

    alter table tbl_printer_group_member 
        add constraint FK_PRINTER_GROUP_MEMBER_TO_PRINTER 
        foreign key (printer_id) 
        references tbl_printer;

    alter table tbl_user_account 
        add constraint FK_USER_ACCOUNT_TO_ACCOUNT 
        foreign key (account_id) 
        references tbl_account;

    alter table tbl_user_account 
        add constraint FK_USER_ACCOUNT_TO_USER 
        foreign key (user_id) 
        references tbl_user;

    alter table tbl_user_attr 
        add constraint FK_USER_ATTR_TO_USER 
        foreign key (user_id) 
        references tbl_user;

    alter table tbl_user_card 
        add constraint FK_USER_CARD_TO_USER 
        foreign key (user_id) 
        references tbl_user;

    alter table tbl_user_email 
        add constraint FK_USER_EMAIL_TO_USER 
        foreign key (user_id) 
        references tbl_user;

    alter table tbl_user_group_attr 
        add constraint FK_USER_GROUP_ATTR_TO_USER_GROUP 
        foreign key (user_group_id) 
        references tbl_user_group;

    alter table tbl_user_group_member 
        add constraint FK_USER_GROUP_MEMBER_TO_USER_GROUP 
        foreign key (user_group_id) 
        references tbl_user_group;

    alter table tbl_user_group_member 
        add constraint FK_USER_GROUP_MEMBER_TO_USER 
        foreign key (user_id) 
        references tbl_user;

    alter table tbl_user_number 
        add constraint FK_USER_NUMBER_TO_USER 
        foreign key (user_id) 
        references tbl_user;

    create table tbl_sequences (
         SEQUENCE_NAME varchar(255),
         SEQUENCE_NEXT_VALUE integer 
    );
