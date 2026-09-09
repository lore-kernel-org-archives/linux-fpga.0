Received: from mx.nabladev.com (mx.nabladev.com [178.251.229.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3A6237B025;
	Wed,  9 Sep 2026 05:49:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.251.229.89
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788933000; cv=none; b=XXMf99Qf+yj5VSptBPmsIbUlmAL3ltZOjdLfpjjE7Mj+vk3HvGHMACiTxJHy99uEEzHSc8Jh05iydcOofuqTHEQTxzmcZQMnM1Bo+ouBA0PUjVcAblVq25hVuVYKGh2NAnpMyu6xu267dba8tDWnXsPwEcIuovZdvYdH6EsXO0c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788933000; c=relaxed/simple;
	bh=87VT4pz/dqKIK6BQR2NcLMbCenPV5hqPV3xCcgm6M2g=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WEgyBbuZdBJdeS4pQfJpGdOBl0tuacvYoauDmYiDDAE44wDdDIG74sGq3hx4nXNfaXXg24QaRUe2bm2OPAfWRFnEtqbivGH+ClSGycfRNTo6TIqKb7S9GpE6aqu5H/0RfeIicF/28XgTCD/cVLj1iJnXR4FK97nkXt//PWZU1EY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nabladev.com; spf=pass smtp.mailfrom=nabladev.com; dkim=pass (2048-bit key) header.d=nabladev.com header.i=@nabladev.com header.b=f5UVi7qv; arc=none smtp.client-ip=178.251.229.89
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nabladev.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nabladev.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nabladev.com header.i=@nabladev.com header.b="f5UVi7qv"
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id BCA0F1019A4;
	Wed, 09 Sep 2026 07:49:48 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nabladev.com;
	s=dkim; t=1788932992;
	h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:content-language:in-reply-to:references;
	bh=KEtXgpc9PlhEQpNkSRRgMcnx2DFsOGROQ6KzVyMwk3k=;
	b=f5UVi7qvBE0SwVxrdW/WVMsGqU0Mem59nwQWSoyDc8KcQNh5Abpg/U8DCi04pvLFaR2D3h
	Ws2yFS9p0u3/uLptZOBisnUDe5QF5eIQ2Qcr6D/KZpM0yM/JrWHcnhz1LaHBp0OJ3f6pCm
	57SUB33mUx37U2JFIS1hRkdPIqGsSit1d7BBlzZSsGRs845TB/PPcaMwbtBybDrYvDU825
	+i1tmxgR1oMj2Trpo9vzvyLVxRiEs7U7uhdzs7ExX3ZJAYpd2ZKYB+MaOS24pcdz/XrxIl
	CZdffOdRSjSsxDcuSq+sUSKO+RkUAIkG7F91B7cuUeRo8JHuEixydkNpN9hyrg==
Message-ID: <fb783b51-d5cb-c2ae-9d26-11df39e40aa8@nabladev.com>
Date: Wed, 9 Sep 2026 07:49:06 +0200
Precedence: bulk
X-Mailing-List: linux-fpga@vger.kernel.org
List-Id: <linux-fpga.vger.kernel.org>
List-Subscribe: <mailto:linux-fpga+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fpga+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Subject: Re: [PATCH v4] driver: fpga: xilinx-selectmap: add csi and rdwr
 support
Content-Language: en-US
To: Xu Yilun <yilun.xu@linux.intel.com>
Cc: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-fpga@vger.kernel.org, Bartosz Golaszewski <brgl@kernel.org>,
 Linus Walleij <linusw@kernel.org>, Michal Simek <michal.simek@amd.com>,
 Moritz Fischer <mdf@kernel.org>, Tom Rix <trix@redhat.com>,
 Xu Yilun <yilun.xu@intel.com>, linux-gpio@vger.kernel.org
References: <20260810062105.299808-1-hs@nabladev.com>
 <ap2Yx8oACWfBKOep@yilunxu-OptiPlex-7050>
 <6a489d2b-b5d1-0455-793f-f4100fd3b3d1@nabladev.com>
 <aqBbFGExUpS0k0yE@yilunxu-OptiPlex-7050>
From: Heiko Schocher <hs@nabladev.com>
In-Reply-To: <aqBbFGExUpS0k0yE@yilunxu-OptiPlex-7050>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3

Hello Xu Yilun,

On 08.09.26 20:59, Xu Yilun wrote:
>> I would change v5 commit message to:
>> """
>>      The driver requests the optional CSI_B and RDWR_B GPIOs with
>>      GPIOD_OUT_HIGH and never touches them again. That flag carries a
>>      logical value, so both signals end up asserted on every board,
>>      whatever polarity the device tree states.
> 
> Yeah, that's clear now.

Fine, sorry for not that clear from the beginning.

> 
>>
>>      Keeping them asserted works as long as a single FPGA owns the
>>      SelectMAP port. That FPGA is the only device on the bus, so it may
>>      stay selected, and the driver never reads from it, so the port may
>>      stay in write mode.
> 
> I think keeping them asserted is a bad idea even for single FPGA, isn't
> it?

You are right, both pins belong to the data transfer, not to the driver`s
lifetime. That a board with one FPGA does not visibly break is not the same
as simply behave correct.

I drop that paragraph, as my patch corrects this already.

>>      It stops working as soon as two FPGAs share one SelectMAP data bus,
>>      which is the case CSI_B exists for. Both devices are selected all
>>      the time, so every byte written for one of them is clocked into the
>>      other as well, and neither can be configured on its own.
>>
>>      CSI_B (Chip Select) selects the target FPGA. Assert it before the
>>      configuration data is transferred and deassert it afterwards, so that
>>      only the intended device sees the bus cycles.
> 
> What if we re-program the 2 FPGAs at the same time? Is there still
> chance the 2 CS lines are all asserted? Can they be correctly
> re-programmed in this case?

In the FPGA layer, yes. Each FPGA is its own fpga_manager with its own
CSI_B, and the only lock the core offers is mgr->ref_mutex, which
fpga_mgr_lock() takes per manager. Nothing there serializes two managers
that share one SelectMAP port, so both CS lines can be asserted at the
same time and then both devices take both bitstreams.

But one layer higher, the only in-tree trigger for a SelectMAP device is
of_fpga_region_notify() calling fpga_region_program_fpga(), and
of_overlay_fdt_apply() holds of_overlay_phandle_mutex from beginning to
end, so two overlay applications cannot overlap, if I see this correct.

I would rather keep this out of this patch.

If you want it handled, I can prepare a follow up patch, and it seems to
me this can be done with a simple mutex in this driver around the write
transfer in xilinx_selectmap_write(), with one lock for all ports.

The port does not have to be held for a whole bitstream, as documentation
says, that SelectMAP takes the configuration data non-continuously, with
CSI_B deasserted in between, so serializing single transfers already lets
two devices be programmed at the same time with each one seeing only its
own data.

Should I send such a patch? And if yes, as a follow up to a v5 version of
this patch?

Or add both patches into a v5 series?

I am fine with both ...

> I mean I think this patch does fix the problem of "always assertion",
> which is good to me. But the changelog seems stop me, it talks all about
> 2 FPGAs sharing the same bus, which seems more complex than just
> manipulating the CS.

Agreed. The two FPGAs are how I ran into this, not what the patch is
about.

So next proposal for the commit message is:
"""
fpga: xilinx-selectmap: control CSI_B and RDWR_B during configuration

The driver requests the optional CSI_B and RDWR_B GPIOs with
GPIOD_OUT_HIGH and never touches them again. That flag carries a
logical value, so both signals end up asserted from probe on, whatever
polarity the device tree states, and they stay asserted for the
lifetime of the device.

Neither signal belongs to the driver's lifetime. CSI_B (Chip Select)
selects the device on the SelectMAP port, RDWR_B (Read/Write) selects
the transfer direction, so both belong to the data transfer. A device
that is never deselected never lets go of the port, and a port pinned
to write mode cannot be read back.

Keep the two descriptors in the driver private data, request them
deasserted, and assert them only around the configuration data
transfer. RDWR_B is asserted first as UG570, note 4 of figure "Continuous
x8 SelectMAP Data Loading", warns that changing it while the device is
selected causes an ABORT on the next CCLK.
"""

If fine for you I can send v5, with no code changes, just some
comment changes as discussed.

Thanks for your patience.

bye,
Heiko

> Thanks,
> Yilun
> 
>>
>>      RDWR_B (Read/Write) selects the transfer direction on the SelectMAP
>>      interface. Assert it for the write cycles that carry the bitstream and
>>      deassert it afterwards. UG570 wants RDWR_B settled before CSI_B is
>>      asserted, a change while the device is selected aborts the
>>      configuration on the next CCLK.
>>
>>      Both are requested with GPIOD_OUT_LOW now, the logical 0 that leaves
>>      them deasserted, and their descriptors are kept in the driver private
>>      data.
>>
>>      A board with one FPGA keeps working. SelectMAP allows the bitstream to
>>      be loaded non-continuously, with CSI_B deasserted between the data
>>      transfers, and a deselected device ignores the bus.
>> """

-- 
Nabla Software Engineering
HRB 40522 Augsburg
Phone: +49 821 45592596
E-Mail: office@nabladev.com
Geschäftsführer : Stefano Babic
