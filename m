Received: from mx.nabladev.com (mx.nabladev.com [178.251.229.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69AD94AA3FB;
	Wed,  9 Sep 2026 10:07:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.251.229.89
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788948454; cv=none; b=BD5KlreRr+ah9M/4nN9whUt1Sai7nnGbhAc9itAHDz9SHZAa9zVvigsHsr+rr2EYRMSkx5rASIzJGhBO2KZs5PLTYXTuqZ29y2pwfNgUUTMHxqL/g78pxVXLxMLrGtFOvZwScOHNdQdatSF6KD6Ts+tJvMTUjrwSSnMFXvC+gGc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788948454; c=relaxed/simple;
	bh=V5UBoopZ3KQVTUPVB5g0l5mZ54qcuD+78LD4jh6PV5o=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=aChdcZbwq4xlTSfFFrMU1R55+QytEXbsNa627niTyRrGR1vEehQfvhyOPqja4Js083uGOtAmQh6ws3/IkRcqwRZrm8IrHEAwN82ow6pLorWzKeSz3DJRFEkuokdxaTqwITwuTdYrHBKomhq9vxRSP0qvnpnDOibKwM+djuOHTko=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nabladev.com; spf=pass smtp.mailfrom=nabladev.com; dkim=pass (2048-bit key) header.d=nabladev.com header.i=@nabladev.com header.b=IFF89JlA; arc=none smtp.client-ip=178.251.229.89
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nabladev.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nabladev.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nabladev.com header.i=@nabladev.com header.b="IFF89JlA"
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id B03AA101CCB;
	Wed, 09 Sep 2026 12:07:21 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nabladev.com;
	s=dkim; t=1788948445;
	h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:content-language:in-reply-to:references;
	bh=t5vFdgJaDV4YUMq5lpmdzQC9P/e5D7d6TtaH7tjrnhE=;
	b=IFF89JlAZBhq582k4BbFlFrFNPjbKkidA5MU0OZFY79LAPStNpNeQj5KGL0ghVxC5YKM52
	ZIPR8zXD4OVjUwDUFLMNRLoTxa2F6gRlFX3ZmmP7Ku1qQTuKrrCdwCvzGm5UDj18Jf1A+l
	TTewT0mjSi7aIxMms1/BKB21JjjUVXXWgeDjsqOg/RtAVC4DQVFKPVSwlXUmJRjoit+Ug3
	k5LJp7VvpzL1QMfkcS4WruRJHrC4cacnxEqFanfaYEnXv+EWAuZPky4Mig+O5yGh3I9bXI
	Dji4wc+hfon/apceuuvOJ55VCVRyPZ1f2oECotTUGQV1yAwo9y+yMlA6cfLRMg==
Message-ID: <71a1e980-419f-35a5-647c-b34463a57c37@nabladev.com>
Date: Wed, 9 Sep 2026 12:06:45 +0200
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
 <fb783b51-d5cb-c2ae-9d26-11df39e40aa8@nabladev.com>
 <aqEAImnHDYWcOdc0@yilunxu-OptiPlex-7050>
From: Heiko Schocher <hs@nabladev.com>
In-Reply-To: <aqEAImnHDYWcOdc0@yilunxu-OptiPlex-7050>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3

Hello Xu Yilun,

On 09.09.26 08:43, Xu Yilun wrote:
>>> What if we re-program the 2 FPGAs at the same time? Is there still
>>> chance the 2 CS lines are all asserted? Can they be correctly
>>> re-programmed in this case?
>>
>> In the FPGA layer, yes. Each FPGA is its own fpga_manager with its own
>> CSI_B, and the only lock the core offers is mgr->ref_mutex, which
>> fpga_mgr_lock() takes per manager. Nothing there serializes two managers
>> that share one SelectMAP port, so both CS lines can be asserted at the
>> same time and then both devices take both bitstreams.
>>
>> But one layer higher, the only in-tree trigger for a SelectMAP device is
>> of_fpga_region_notify() calling fpga_region_program_fpga(), and
>> of_overlay_fdt_apply() holds of_overlay_phandle_mutex from beginning to
>> end, so two overlay applications cannot overlap, if I see this correct.
>>
>> I would rather keep this out of this patch.
> 
> Yes, that's the way to go.

Ok, I send the v5 soon.

>> If you want it handled, I can prepare a follow up patch, and it seems to
>> me this can be done with a simple mutex in this driver around the write
>> transfer in xilinx_selectmap_write(), with one lock for all ports.
> 
> "one lock for all ports" is still illogical to me. The FPGAs on
> different ports won't interfere each other, is it?

They do not, you are right. I first thought to solve it "easy" with
a mutex around the write... but nothing tells the driver which managers
share a port.

Two managers on one port and two managers on two ports look exactly the
same from inside the driver. And so we may we lock the write unnecessary...

I have to think about...

>>
>> The port does not have to be held for a whole bitstream, as documentation
>> says, that SelectMAP takes the configuration data non-continuously, with
>> CSI_B deasserted in between, so serializing single transfers already lets
>> two devices be programmed at the same time with each one seeing only its
>> own data.
>>
>> Should I send such a patch? And if yes, as a follow up to a v5 version of
>> this patch?
>>
>> Or add both patches into a v5 series?
> 
> No, fix the existing problem. 2 FPGAs are another topic.

Fine.

> 
>>
>> I am fine with both ...
>>
>>> I mean I think this patch does fix the problem of "always assertion",
>>> which is good to me. But the changelog seems stop me, it talks all about
>>> 2 FPGAs sharing the same bus, which seems more complex than just
>>> manipulating the CS.
>>
>> Agreed. The two FPGAs are how I ran into this, not what the patch is
>> about.
>>
>> So next proposal for the commit message is:
>> """
>> fpga: xilinx-selectmap: control CSI_B and RDWR_B during configuration
>>
>> The driver requests the optional CSI_B and RDWR_B GPIOs with
>> GPIOD_OUT_HIGH and never touches them again. That flag carries a
>> logical value, so both signals end up asserted from probe on, whatever
>> polarity the device tree states, and they stay asserted for the
>> lifetime of the device.
>>
>> Neither signal belongs to the driver's lifetime. CSI_B (Chip Select)
>> selects the device on the SelectMAP port, RDWR_B (Read/Write) selects
>> the transfer direction, so both belong to the data transfer. A device
>> that is never deselected never lets go of the port, and a port pinned
>> to write mode cannot be read back.
>>
>> Keep the two descriptors in the driver private data, request them
>> deasserted, and assert them only around the configuration data
>> transfer. RDWR_B is asserted first as UG570, note 4 of figure "Continuous
>> x8 SelectMAP Data Loading", warns that changing it while the device is
>> selected causes an ABORT on the next CCLK.
>> """
>>
>> If fine for you I can send v5, with no code changes, just some
>> comment changes as discussed.
> 
> Good to me.
> 

Thanks!

bye,
Heiko
-- 
Nabla Software Engineering
HRB 40522 Augsburg
Phone: +49 821 45592596
E-Mail: office@nabladev.com
Geschäftsführer : Stefano Babic
