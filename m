Received: from mta0.migadu.com (out-67.mta0.migadu.com [91.218.175.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB6B542E41A
	for <linux-fpga@vger.kernel.org>; Fri, 18 Sep 2026 15:07:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.67
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789744045; cv=none; b=gXsbYss3dev9KqahxTJOCjhPXf6+TlgoUagVAE4mSkaxnMMQ+AHSRhsgldg2XFLhvqmtTjnwklN3nKplduyGPDy8HUw3p0gfOfJLqZdg31FZV6sBUMCWufGY0hbsqX0xbUgksoUijFDvSH1h+iNuGhZPiGmaxj1CScgGKrdVRMI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789744045; c=relaxed/simple;
	bh=6ATLnyCaLHvD7n05SCq7fLNOH0LPoLecfJlC0QyV6/8=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=Ol4ZiIBPZiVgBKDnX3C5sQWLqSuxrJjpo4RIRf2QvgjtsAGWsl7Kpkcm0oBFPWuY6o6OizBbUCcH2WnNgI2ngxuowvHtIzwuWGsEmmbfyOpFqODAt9tqe4TUUMOQRx50hN2ayIMA9Ludc73vrTRzNRvKU39HQ1HOo7XLroa8800=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=PLuh6+TZ; arc=none smtp.client-ip=91.218.175.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="PLuh6+TZ"
X-Envelope-To: linux-fpga@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=6ATLnyCaLHvD7n05SCq7fLNOH0LPoLecfJlC0QyV6/8=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1789744040; v=1; x=1790348840;
 b=PLuh6+TZ8Qi4yRyCaDsuDRiHsj8EbcPytt9FPuOeoAsNKhDTWXBPXXGFPOKzsi9ZtOmrYGaf
 qoDeQUdHJBWVygEqWD8+1ajVXnva8RCDi9rIh3GeZM9XqS5sVb8YWSdZQ4Ll4mqB0/rWZDFFjJz
 qw4avAIpfAEPPjPrM295A8Q0=
X-Envelope-To: linux-fpga@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 729c408859e620f4;
	Fri, 18 Sep 2026 15:07:10 +0000
X-Mizu-Trace-ID: 729c408859e620f4
X-Migadu-Flow: FLOW_OUT
Message-ID: <11b1a792-f8b1-4fce-8a7a-8352149febcf@linux.dev>
Date: Fri, 18 Sep 2026 17:07:07 +0200
Precedence: bulk
X-Mailing-List: linux-fpga@vger.kernel.org
List-Id: <linux-fpga.vger.kernel.org>
List-Subscribe: <mailto:linux-fpga+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fpga+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH] fpga: region: Add support for FPGA region variants
From: Marco Pagani <marco.pagani@linux.dev>
To: Xu Yilun <yilun.xu@linux.intel.com>
Cc: Moritz Fischer <mdf@kernel.org>, Xu Yilun <yilun.xu@intel.com>,
 Tom Rix <trix@redhat.com>, linux-fpga@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <akPZoGCyQW+6+hDX@yilunxu-OptiPlex-7050>
 <5dbd4ac8-a532-4889-bae1-f0bab9a99267@linux.dev>
 <akyyp1GCecWj2Bk2@yilunxu-OptiPlex-7050>
 <417b510f-0f6d-4695-97f5-3fc19b9377b9@linux.dev>
 <amCn8UYdybT+RRnq@yilunxu-OptiPlex-7050>
 <9d4af487-69a7-4a0d-9335-35c3a057de54@linux.dev>
 <anBfAa4LpjbmYHIc@yilunxu-OptiPlex-7050>
 <db7cfe9e-b2ba-4323-bff9-44598e1f70bb@linux.dev>
 <anl8891cH+bUfsGY@yilunxu-OptiPlex-7050>
 <4dbdb52e-1b28-432e-a3a7-ad9c44f17d27@linux.dev>
 <aoJ6paA/8ndpJ17y@yilunxu-OptiPlex-7050>
 <8848432d-45b0-4efe-adf3-adfb64fe0899@linux.dev>
Content-Language: en-US
In-Reply-To: <8848432d-45b0-4efe-adf3-adfb64fe0899@linux.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 17/08/2026 18:14, Marco Pagani wrote:
> 
> 
> On 17/08/2026 05:06, Xu Yilun wrote:
>>>> But if the no-verification-in-driver is denied, I think the thing we
>>>> need to do is to verify the binding between the DT description & image.
>>>> After we've verified the DTO & the image is a valid pair, they are not
>>>> arbitrary, whatever the DTO does is necessary to the updated hardware.
>>>
>>> I think we agree on this. Ideally, we should validate the complete
>>> {config, image} pair. However, I don't see how using DTO at runtime can
>>> help with this goal.
>>
>> Validation is not the goal. Re-enumeration is the goal. DTO is what FPGA
>> is now using for re-enumeration. Validation helps DTO if you want extra
>> integrity.
> 
> I would argue that validation is a requirement for any userspace
> interface, while I do agree that re-enumeration is the goal. In my RFC,
> re-enumeration is triggered using the DT infrastructure every time
> userspace switches from one variant to another. Variants can be thought
> of as pre-validated DT fragments baked into the base DT, rather than
> DTOs ingested from userspace at runtime.
> 
> To clarify my position, going back to a couple of messages ago:
> 
> - As I understand it, the current upstream consensus is that hardware
>   devices must be responsible for verifying their own firmware.
>   So, the kernel is responsible for protecting the integrity of its
>   own configuration (live DT), while the reconfiguration engine is
>   responsible for validating FPGA images;
> 
> - If this is not sufficient, and there is a requirement to secure
>   /lib/firmware, it should be done at the filesystem level using
>   the IMA subsystem;
> 
> - However, since not all FPGA reconfiguration engines support crypto
>   image verification, and not all SoCs/platforms have a TPM IP or
>   support for a TEE, we might consider having a subsystem-specific and
>   optional check for the {config, image} pair as a *future* extension.
> 
> 
>>> On the contrary, it would put us in a situation
>>> where neither element of the pair is guaranteed since it enables the
>>> user to feed arbitrarily forged DTOs.
>>
>> As you referenced, no OS component (even the kernel) could guarantee the
>> functionality of the binary for a device, only the device can. So what's
>> the difference who provides the pair?
>>
>> The only thing matters here is integrity and authentication, which is
>> totally a different thing from kernel-user privilege.
>>
>> I'm also confused you keep on telling that userspace is arbitrary so no
>> userspace interface, which seems to suggest kenrel should never get any
>> input from user.
> 
> My concern isn't about accepting user input in general but rather about
> the type and scope of that input. I think there is a huge difference in
> terms of the security between:
> 
> - matching a string that userspace sent via sysfs and then applying a
>   safe configuration already contained in the base DT (validated from
>   a FIT image).
> 
> - having userspace directly pass the kernel DT configuration (as a DTO),
>   which the kernel must then validate (both syntactically and
>   semantically) and apply.
> 
> In the first scenario, userspace is like a customer selecting from a
> menu of pre-approved dishes, and then the kitchen safely prepares it.
> 
> In the second scenario, userspace is like a customer stepping into the
> kitchen to cook their own meal, forcing the chef to constantly supervise
> them to ensure they don't burn the place down.
> 
> 

>>>> It is possible. To be more efficient, I think we should invite
>>>> boarder discussions.

> Following up on what you said two messages ago, I think we should invite
> the DT people and ask for their input to help move this conversation
> forward.

Hi Yilun,

Is it okay with you if I CC the DT people to ask for an opinion?

$ scripts/get_maintainer.pl drivers/of
Rob Herring <robh@kernel.org> (maintainer:OPEN FIRMWARE AND FLATTENED DEVICE TREE)
Saravana Kannan <saravanak@kernel.org> (maintainer:OPEN FIRMWARE AND FLATTENED DEVICE TREE)
devicetree@vger.kernel.org (open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE)
linux-kernel@vger.kernel.org (open list)


Thanks,
Marco

