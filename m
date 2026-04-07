Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 970F3282F3C
	for <linux-fpga@vger.kernel.org>; Tue,  7 Apr 2026 17:32:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775583147; cv=none; b=u+g7UI0LX05KcYJhYmPPsOz0AHYfToDDgc+VCQjBO/Sfx4APU4EUbChOmyCSEr95d6UMpMALJzDQdtAoFfdcHGSIt2EhaeO6jvVKC0GLPkZZU2toToqKpl3JRC93iNz2klJZp74aV2B3hWOIEdBamSfSqbt6Gic9XrIllQP0yH0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775583147; c=relaxed/simple;
	bh=2wYO5D/BuxBvW82ZWdwBdAgbv77/vthjMh+/d5X866Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tjOAH+36KaKww1RjLn9mjA23j4qnBe9IW19mTWTb7GqpJFAGEvG+ALmkYhcDlACH5/levXDh2EMYgJEpClfFDrge93Xd5LnaeONU7fgMTxIOJDDy8142WMJK/yXsL+sm6UKAW3Lc1jvJamUN4nIwLUE4yo+a11qz8jWCB7uuDu4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=spPenUxj; arc=none smtp.client-ip=209.85.216.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="spPenUxj"
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-358d80f60ccso3424116a91.3
        for <linux-fpga@vger.kernel.org>; Tue, 07 Apr 2026 10:32:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775583146; x=1776187946; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=5cVQdVcDn/x8UdvOjp6K2mfAS/Bs2g95UfBr5r7LzxA=;
        b=spPenUxjU64rq6C2qt9YH1ojwsyyhNu91xhm3d5YA0/UnVkzRBzTf3NgEbrvzywqvK
         HtOEfVO52rf5Qx3vMHKcDrFCMEEDe7QjRw5P+1QmUxBjqOnDag5j6rGcIyMrn2SbgAdp
         lUk7vjDdggt2wCap4p1MmeCZVh2FONdonAVUKfnt7hjFvHVjGtWU6C85T06EqWSOGOYV
         wn6JZMVg+L/gzN0d9gvYDcdXBzkGGf7PcJOqX+EI9aVTU0BLpdPePDvJlEq7vSpsyNr3
         nRCy4ZQExc2MJzTXUcLkzX0z7M+4BOqhrWt+QI9pfVHdn4Yg9E/guvuVzao37Imh9umy
         rsVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775583146; x=1776187946;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5cVQdVcDn/x8UdvOjp6K2mfAS/Bs2g95UfBr5r7LzxA=;
        b=UcDAXOLwdpxJUmgZz+1HDRYgxHqm3aSyvXXyrcfnJvLJNIU4kwBLOcy4gBUEYjx+7B
         KBJ7FQY2b/+xyvSRU1evNEfu42m4ziKH1H0fvz8MvdCVImwlmIuYwo85+EgulLbpEdSF
         aUc3uCqlO+Y4Fvu7bWlVSgqXTYBYusF/xj6lqV422C9qjTylFCB6TfXBhrw9bA2rDSZQ
         Lrvu+bXmGMwehSohzCEuqRInb19eMuJsBngu20/NKn425jUJNGOpBKcP0MiZWGv5UW7l
         E4vurU5cxYj5eAdR5gEVaHIpRa8O1V7k9nncluBZlTKGrnDsPjFyQ0y+Bl+sqQkaLQ+U
         Amww==
X-Forwarded-Encrypted: i=1; AJvYcCXWy+knJl8gai/JUAyPGfBOXEEuD4+c6VRb91+wU2Kl+Y7qFdxQ3+UiSwy+n5kf/LdDIJ51f1oFd7b9@vger.kernel.org
X-Gm-Message-State: AOJu0YyWXjFvwz8w0uObqKdxpJkPd29RmGFJ4yxw2x/WocQolfX57QTf
	tjQCOm9OcpX7ZQHHXHvVcwCyc4o9Yk4znrkgTdzQUvW9V4OkFgtHsz3r
X-Gm-Gg: AeBDieu6rSuOjh3yAbJ1aEU3TN4libs3sY4YA2JeNUflgeZgGSGATrokdlKc4DQN+sI
	tuu13oncvixolhkkTd7AFISP07XGJmZ2iWieQFepDfvsW1nzZ2uzGxS8tcnO5X4nTsJHr/nEQNh
	cLhwanKnhog7DZjp8C6aI3Uiiyo6PTKHzM/IEmlopHEpuvvVy3r7eAPgNcp5EfIi9VQ6/IsPxfM
	qk7ahtVZhmHPsWTmeMJJOGWIbxsswl5ifWD0TTOYKeFQ7hmm1Y0IgcdBkV9WKc6y9BGMCSBNXU/
	M75aiuWuCewRPcgW+jSRBpChrTyKaA8oGXcryR5BYGielEYyIc/0SXP5r1hGsvBLImVbkekyYlI
	ZR6waoSfBinggwb1myTAfSSSl3axPW+403NNG38au0T6L3tqjd0/6Z4kYAGhjlU06NChkkh4H/s
	jmJlBtRESQgPAqkTYT4F1aJcqB3polE3ztiIsUDpmVSOsffau1cw==
X-Received: by 2002:a17:90b:4c0b:b0:35c:fa8:3673 with SMTP id 98e67ed59e1d1-35de6946f27mr17738388a91.22.1775583145877;
        Tue, 07 Apr 2026 10:32:25 -0700 (PDT)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-35dbe95abc3sm23531420a91.15.2026.04.07.10.32.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 07 Apr 2026 10:32:23 -0700 (PDT)
Message-ID: <644c9b98-cf7c-4e5f-bbde-7d848583f8e1@gmail.com>
Date: Tue, 7 Apr 2026 10:32:19 -0700
Precedence: bulk
X-Mailing-List: linux-fpga@vger.kernel.org
List-Id: <linux-fpga.vger.kernel.org>
List-Subscribe: <mailto:linux-fpga+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fpga+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] fpga: ts73xx-fpga: add OF match table for device tree
 probing
To: Phil Pemberton <philpem@philpem.me.uk>, Moritz Fischer <mdf@kernel.org>,
 Xu Yilun <yilun.xu@intel.com>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>
Cc: Tom Rix <trix@redhat.com>, linux-fpga@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260407172730.1779804-1-philpem@philpem.me.uk>
 <20260407172730.1779804-3-philpem@philpem.me.uk>
Content-Language: en-US, fr-FR
From: Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <20260407172730.1779804-3-philpem@philpem.me.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 4/7/26 10:27, Phil Pemberton wrote:
> The ts73xx-fpga driver currently only matches by platform device name,
> which prevents it from being probed when the device is described in a
> device tree. Add an of_device_id table so the driver can match against
> the "technologic,ts73xx-fpga" compatible string.
> 
> Signed-off-by: Phil Pemberton <philpem@philpem.me.uk>

Reviewed-by: Florian Fainelli <f.fainelli@gmail.com>
-- 
Florian
