Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AE7D3DA5B6
	for <linux-fpga@vger.kernel.org>; Thu, 23 Jul 2026 07:00:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784790023; cv=none; b=IYPH99j5rT5EXUGiPfa1QdOJoWX+9bOON87KiKeYDO8akVxmDEMNvEYoKQfL9iEg2er69eSeS5TiApoZE8lU2UrsPtDUwLbbsq0MOEnvEONlJK0FA0qNAddGqwR/o0dBFJI4t/l6JUxaE3Xi3Bhk4QOi+VQrxPgcsWR3lV64Vpo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784790023; c=relaxed/simple;
	bh=VILMoO/Jv4/7xDOVCpc8wmFeivgVhLgZgo/OL3J+MMc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pyNIB0Bu9pmh51N51/mHVNRSSKzKz/9gMAqqHst9COqu9f9MnYC5qKm+LvNX9t/5LseXNqt7hbOMHmFOL72PvhOC4cv5wj501IJiNstLtUoBPIjUbnwBn3upEjyUloJirtnPxFWz08ajUI95VYih1J9OrW8hacziAAv3sSeGRRM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dPEo91DZ; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dPEo91DZ"
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-2ced3386430so3703975ad.1
        for <linux-fpga@vger.kernel.org>; Thu, 23 Jul 2026 00:00:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784790020; x=1785394820; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Rvc1Q8Yuo59f8Js6D1YtI1CZ2BliYzQWnNcO/qXOPsM=;
        b=dPEo91DZazOXFD0GDYmjRfOETcT126NZQ9iwDd7QEMHHehbZ7gKJiBfVUOFKzZyReI
         JX1Q/Vg9L3v5pACCG+/npWYzF+vwT9A9WJVyrw6MTIFxlR1m2iC1KTHAzIjZhSXtjCSd
         9VPpDpK8LIWqVEuaJH+OdbP7cXfuKpW5tHBVpT18W9yielPbB6W1e5V12nQmlAAP23xA
         BTIt5wbPmcLJya6I/xYwMAliOVe0HMtHjkSRrx76T7Jk8RHvM5pBKAldNYmBfkQadFwO
         OKAyy4rxK8rFjIGFxhE1ZFn/LpSyXO+y6mcLlQmE6AVCFT7ZH24Kg9cUge4h4vCU6i61
         x5aA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784790020; x=1785394820;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Rvc1Q8Yuo59f8Js6D1YtI1CZ2BliYzQWnNcO/qXOPsM=;
        b=YfOlZ14PXrffrsEOZF+MTYGvfxpdknWcyJ+zJsueg0M5NQQxjU5UoTddCy4Ee6WxHC
         0+NL0HdRChshrOYzscpeyBUSisldubFu0rR1ivRf0EYyxhABppSvyKQtjG8Gj+lnpG14
         NZ3fdGotJB6FBoEC8tzoXm4Lpr4kYK/MoTzQmXobQBaDSux3cLa3kuFo6VuBFih9ZgzL
         /gHnBKnr8/mg8W8itezDap/XYkTBcMy3kktJFGihaI3+Jlbuy851AOwA0taajKoPV6W6
         Aj143dG4LuI+jzpityDg8TJ0vq9aboL2LMkrfjHuxPQb1iYzseu5p10wMUFPTl1JsVon
         w5tQ==
X-Forwarded-Encrypted: i=1; AHgh+RqZlZllWmCL4iL+tmQSCSgPsu9XtHXU4q4CylmZvnhzoI01EqoBxkTJg9r1VcyB2l0zfBdTt1JUUo9d@vger.kernel.org
X-Gm-Message-State: AOJu0YyzJp+QXy71AHhu9VoPCPWsxr4q8i609y8+TY1Ynv3qjucjlFfw
	skyAtdc6Q6SPoQa+ClD2lNGMwgrBwzGMy+VsiB9WEB77tvgx2uw82rzG
X-Gm-Gg: AR+sD12Bhxeg0ZZ3xtNgFYv9WzLQVie5UjHrlgXEdWAnRKupMi95P+XUEacCqNEMsEl
	/IrNu66OWyvO7Tk4WEtWn285iPP1QBL3A5PKRLArzF1C0558tpstAx9d52mcyObO/j4VGIyJH1w
	i/UYFWoINukXHulOuLZ8w9b6HAdJZmmB5zlYJDISMZ09nqHXn0kLuLVWCLJSF7RtYX6DdnuDMNN
	IEcNzxNUR0179qjXVknBf0TR5SYnPBeJ65RLdlZjwuCgOMy9I6Is04O3iiA9B3KU+9Yyzy0kAHE
	qIexrDODPrFcuznzdm1K3tBvRB3r4aZDHer7QwYVgr9Ko5QiNHTL+vzI/AfFT8FjIROiJfhVhEt
	hCQRn2nPssVcy47WgjWEpJQor3Ftrywf4VQz34yvud2c+LvM+7LBbP1MQIsbmLRzeq8cTm0Wkr2
	4GcFpnwrKttUEdQNfuyIjma1Oirnsq7p2rD9l15Tk0gLNzFrXPDm4x
X-Received: by 2002:a17:903:3508:b0:2ca:61bc:317c with SMTP id d9443c01a7336-2cfa71d8e4amr23738485ad.13.1784790020086;
        Thu, 23 Jul 2026 00:00:20 -0700 (PDT)
Received: from [192.168.11.6] (FL1-133-202-37-214.tky.mesh.ad.jp. [133.202.37.214])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2cf8f34bb48sm27652235ad.65.2026.07.23.00.00.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 23 Jul 2026 00:00:19 -0700 (PDT)
Message-ID: <e849a2b1-58b0-4423-81bf-ec833fa5ee83@gmail.com>
Date: Thu, 23 Jul 2026 16:00:18 +0900
Precedence: bulk
X-Mailing-List: linux-fpga@vger.kernel.org
List-Id: <linux-fpga.vger.kernel.org>
List-Subscribe: <mailto:linux-fpga+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fpga+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] fpga: altera-cvp: Propagate PCI config access errors
To: Xu Yilun <yilun.xu@linux.intel.com>
Cc: yilun.xu@intel.com, mdf@kernel.org, trix@redhat.com,
 linux-fpga@vger.kernel.org, linux-kernel@vger.kernel.org,
 Daisuke Matsuda <matsuda@preferred.jp>
References: <20260701092633.5146-1-dskmtsd@gmail.com>
 <20260701092633.5146-2-dskmtsd@gmail.com>
 <amGNwqOFs3oLXhWt@yilunxu-OptiPlex-7050>
Content-Language: en-US
From: Daisuke Matsuda <dskmtsd@gmail.com>
In-Reply-To: <amGNwqOFs3oLXhWt@yilunxu-OptiPlex-7050>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2026/07/23 12:42, Xu Yilun wrote:
> On Wed, Jul 01, 2026 at 09:26:33AM +0000, Daisuke Matsuda wrote:
>> From: Daisuke Matsuda <matsuda@preferred.jp>
>>
>> The CvP control path accesses the VSEC registers through PCI config space,
>> but several reads and writes ignore the return value. If a config read
>> fails, the driver can make decisions from an undefined register value and
>> continue programming with bogus status or control bits.
> 
> Searching from the kernel, most pci_read/write_config_dword() don't
> check return values. Could you help me understand why they don't but
> this driver has the specific need?

Hi Yilun,

Thank you for taking a look.

I agree that the vast majority of drivers do not check the return values, and I don't have a strong reason to make this driver behave differently.

I'll drop this patch and send a v2 with only patch 1/2.

Thanks,
Daisuke

> 
> Thanks,
> Yilun

