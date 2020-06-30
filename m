Return-Path: <SRS0=WJZw=AL=vger.kernel.org=linux-fpga-owner@kernel.org>
Return-Path: <SRS0=WJZw=AL=vger.kernel.org=linux-fpga-owner@kernel.org>
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:43508 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726122AbgF3SoY (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Tue, 30 Jun 2020 14:44:24 -0400
Received: by mail-qk1-f197.google.com with SMTP id q192so5015675qka.13
        for <linux-fpga@vger.kernel.org>; Tue, 30 Jun 2020 11:44:20 -0700 (PDT)
Subject: Re: [RFC 1/1] fpga: dfl: RFC PCI config
References: <20200630171656.20151-1-trix@redhat.com>
 <20200630171656.20151-2-trix@redhat.com>
 <67f7f2b8-3567-aadd-30d6-4cfbc0bc8ce5@infradead.org>
From: Tom Rix <trix@redhat.com>
Message-ID: <78a250ab-29ad-f7cb-3fa2-482e76db207a@redhat.com>
Date: Tue, 30 Jun 2020 11:44:16 -0700
MIME-Version: 1.0
In-Reply-To: <67f7f2b8-3567-aadd-30d6-4cfbc0bc8ce5@infradead.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-fpga-owner@vger.kernel.org
List-Id: linux-fpga@vger.kernel.org
To: Randy Dunlap <rdunlap@infradead.org>, hao.wu@intel.com, mdf@kernel.org, corbet@lwn.net
Cc: linux-fpga@vger.kernel.org, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org

> I haven't tested this, but in general it's not safe to select something like
> SENSORS* or HWMON* unless you first check that CONFIG_HWMON is enabled.
> Otherwise this would usually cause kconfig warning(s).
>
> But don't add things like
> 	select HWMON
> 	select SPI
> 	select SPI_MASTER
>
> because we don't enable subsystems (like HWMON or SPI) just inside one
> driver's kconfig entry.
> The driver(s) should instead depend on HWMON, SPI, SPI_MASTER etc.

Yes, I thought this was ugly. The next rev addresses this issue.  The config will not be fully automagic.  User will have enough information in the doc to figure out the other subsystems.  

Tom
