Return-Path: <SRS0=5mHA=DN=vger.kernel.org=linux-fpga-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A2AAC41604
	for <linux-fpga@archiver.kernel.org>; Tue,  6 Oct 2020 17:35:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AD7AA20782
	for <linux-fpga@archiver.kernel.org>; Tue,  6 Oct 2020 17:35:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WTYBfnSA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726002AbgJFRfM (ORCPT <rfc822;linux-fpga@archiver.kernel.org>);
        Tue, 6 Oct 2020 13:35:12 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:55994 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725972AbgJFRfM (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Tue, 6 Oct 2020 13:35:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1602005711;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=iRg0GJHVofMir4bUhfVjc9yEZQKs/9hfnaxI5B7+zds=;
        b=WTYBfnSAfZSiyVCXP9c+tlHO5CJu/pQXWamifpFRwFKpD//Ot8HsJMB/gXankOJAZ6dIcf
        8t7O1rMtufMx8a7Wagstt5XK0WPwEJH3jda4BI5+doNfUtg8D7/9VCW/4cxDXuatIJZg+l
        TpKeoeGxPzPEMO6K292qcuFT9XjQtz0=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-530-YH1g-xB0MbihVWG0cMfkNQ-1; Tue, 06 Oct 2020 13:35:09 -0400
X-MC-Unique: YH1g-xB0MbihVWG0cMfkNQ-1
Received: by mail-qk1-f200.google.com with SMTP id c19so9765031qkk.20
        for <linux-fpga@vger.kernel.org>; Tue, 06 Oct 2020 10:35:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=iRg0GJHVofMir4bUhfVjc9yEZQKs/9hfnaxI5B7+zds=;
        b=ZTESColinFJlWiHlJl7NV60W1yb6OGsv43nNw+yUi3yzmrAnyYKhrI/5SG+xwV6NCN
         7OUNm6NQbSeBZSYDHibdBet99eTHtmSvZSCDKGli5YoQEjaMXGJHM2YLJsRM8mIn9kJL
         3W4xXwHDJ2QfjkjXMzFYQg3keEDrfRLZ2dwrM1rp1jl+YskV7+pnALCq+6rjdcM3rlHG
         r0jUFHdX9X+UU49lUKkoLK2SkDxe9dVttAyQ+CAbR2U98jCcKIwhQSJH3zXhT5GD2+6V
         N/E59YHZT5oldXAJwnEzMILRMGiAOxj7bqFLa/SqIeZkZKzPHSPfGJrHbpVQ8sinK4VG
         pHaw==
X-Gm-Message-State: AOAM530f0PhhKWg+aeMSoszZiD4Cz5z3Fzt2fbB1634IBoq9svqZHLL/
        VsKBOg1Icd0y+wqBeSEt6ybPqtdDrNHUFZP2s7DCzF8WhZUMjIhZfP/ZGBvWKuDiXG9EUSyEtVp
        y0+MVjrQs7YdlKDhd92b2mQ==
X-Received: by 2002:a05:6214:1852:: with SMTP id d18mr6021080qvy.32.1602005709096;
        Tue, 06 Oct 2020 10:35:09 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwzRnQpbyOrNXUS055K41hsMO7RJdIiY4zHjkZi7NHkqShF3RvFMy8E0WWJoYdq4xMXjpIASQ==
X-Received: by 2002:a05:6214:1852:: with SMTP id d18mr6021067qvy.32.1602005708880;
        Tue, 06 Oct 2020 10:35:08 -0700 (PDT)
Received: from trix.remote.csb (075-142-250-213.res.spectrum.com. [75.142.250.213])
        by smtp.gmail.com with ESMTPSA id l13sm2936891qtv.82.2020.10.06.10.35.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 06 Oct 2020 10:35:08 -0700 (PDT)
Subject: Re: [PATCH v2 3/6] fpga: m10bmc-sec: expose max10 flash update counts
To:     Russ Weight <russell.h.weight@intel.com>, mdf@kernel.org,
        lee.jones@linaro.org, linux-fpga@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     lgoncalv@redhat.com, yilun.xu@intel.com, hao.wu@intel.com,
        matthew.gerlach@intel.com
References: <20201003012412.16831-1-russell.h.weight@intel.com>
 <20201003012412.16831-4-russell.h.weight@intel.com>
From:   Tom Rix <trix@redhat.com>
Message-ID: <465d98a3-2e24-caf0-02f8-54e8505ab803@redhat.com>
Date:   Tue, 6 Oct 2020 10:35:06 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20201003012412.16831-4-russell.h.weight@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org


On 10/2/20 6:24 PM, Russ Weight wrote:
> Extend the MAX10 BMC Security Engine driver to provide a
> handler to expose the flash update count for the FPGA user
> image in sysfs.
>
> Signed-off-by: Russ Weight <russell.h.weight@intel.com>
> ---
> v2:
>   - Renamed get_qspi_flash_count() to m10bmc_user_flash_count()
>   - Minor code cleanup per review comments
>   - Added m10bmc_ prefix to functions in m10bmc_iops structure
> ---
>  drivers/fpga/intel-m10-bmc-secure.c | 31 +++++++++++++++++++++++++++++
>  1 file changed, 31 insertions(+)

Looks fine.

Reviewed-by: Tom Rix <trix@redhat.com>


