Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94ED633D4E8
	for <linux-fpga@vger.kernel.org>; Tue,  7 Apr 2026 17:32:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775583160; cv=none; b=RQwTdD6LAY2731sseqsA0IMWa/31B5wTKW/sLv1HZkt1G7RQbVsUNRqPA6ls7hVxgWQzxtINMalGdnV+yje+rBaFnWtKlkChXoyJrQSUli2Az4emzBZFDYknRzAbUjCp2u496gPw6bRSOhpFL+vdgLy+AqeZiXHwOG3BuCx5gag=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775583160; c=relaxed/simple;
	bh=96IxDbYipWYISMVgppXL6FngvjfItqxe5eExWZvHusY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DxSZUt1qoWURglBVpcBK4EAi2WdPCTKNE0VhuFCDYk3b8oBE6dmMkZMrTuhaXZtF91n4EVTZbSDNWNRUiezViw5WLOrd9FbIS47BG4ToVbtRCuGjKirNoGCUJ+j3kN5uxWx6qyR5oW/LDZWLPD5NDFUGin+6mHSYHmtJDEnliqU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Yx5zLUD0; arc=none smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Yx5zLUD0"
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-35d96be7c13so77515a91.0
        for <linux-fpga@vger.kernel.org>; Tue, 07 Apr 2026 10:32:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775583159; x=1776187959; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=DmBs1pC2+g4fvvLGZVFgA2jNmZXb31c2twmWE1SEdkI=;
        b=Yx5zLUD0D98VSchcM5q0WsiF43qX7a/WVj24nEDg7+n377PgxJ8au5Xo109o3GNTol
         mhAoR6lkXuTkOUNcMOuCqXQv8s7FYOnlFBsKKuqG9jsHD7qKWUES6Gnw0Lw8S3kK6lIB
         8fHY3SGV0HZO0zClvzq1JHeh5ATov+jV2Ohh1l3NM9NcuTvUMAWlIfdUiyJcBVPL2zgR
         QWg2KMst/aeld5RViaoa8TFTWLuE0yn4ExAu38/D39+puW20hNzidBl7BHjG1u2t1yjy
         /Ge8vKiyg8ipp5lIU2nEWdSkfGuo8NMR+yEWDXOOsM2uOXfm7FjAZG0L4IGo4onJLwTJ
         myBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775583159; x=1776187959;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DmBs1pC2+g4fvvLGZVFgA2jNmZXb31c2twmWE1SEdkI=;
        b=nIFy4NRJsj09VCDEsG7HJ3k76SebZgzYW47Xq6a9Up0vsibwmUoG6UlKGef8Ox4hRk
         9JjyT7PxHX/5gAVqOEx+shHlGi7gRGQOUyad37LqtIn6edie28eVX+Oy9BzfUSUT3mEi
         nG8OjALppT1zlGIaawrSVWbEKkzmdVZ6wzKgPnG0oe/xnp0zXHZ1QP6eOHJLENZ5SyXM
         QQnTYtagVZTw0XkxWZcbo941kWkR+ABw1Sy4qjo0JJC6ZDGQgwMWsaJEkCvoR/Sablkx
         RHFgMcCJNRVksYw7pk0RCQWVqOXnWQeR+ILTYxxLmcXKmO17y6dZQQGbIa0xfTyLyD3f
         Dr4Q==
X-Forwarded-Encrypted: i=1; AJvYcCWPM80mKsXFo7SoWugW3v7tpJ88KDx4BfGSzHlNUoGpwbMBhjH0kXNFH26r31PFI4+lNu0OJkyjK4iy@vger.kernel.org
X-Gm-Message-State: AOJu0YyEUaLSHxg8aUGw7z60YpRCJX8ZfxboBbt+opPiAnPMJbaNxqVY
	hoNJpUba8s///afhZXyvKhtJcgCMMuMFHxcKzBAWVA7T6e3h1CwWLSz6
X-Gm-Gg: AeBDiesq4fnj2fQmF+LeEXa7BNYC0lG4Fiu1zCvDAv6NMvmex4vFsZQRCz1jW9exTVv
	N04kqTHQg1z1PUmQWpEB21eTVsMptYaXQ9PgCKf5vM8k0ZGPJNP8Hvr8h0UmCJWEjkR9CnyVxgs
	1MDsQ60b6BxvDOXDFrmy6amDrb3upSMzBpu9TzV4FQ/JTqLrrmHinyDbhLTR8Iuj4RcTVY0NZSK
	ImKTADd2QJa8H4NCoEkoU2nnp5m2ryTTSqeLGtOOv28hwE2Ks31mcIxLYVNiW+7gpBlJFctDqiI
	U/wyTg+TJF8UoROSoaMpg1ijkISHuAyqCR84fusnE2MbdKQx5dZk6kbS7bLXDmKl1eQBvpo+ZXP
	Y3GKwV4iL96xLpN4HXouJQrR6MPJFIU5WeekizXvkV8Q6HciloS4s1Erx76d/CaD39BwYiwehgG
	T6ZT+670u61A9j4o9kn3tcXXLyIgKK14lED+T8MDzWhWESNwag+A==
X-Received: by 2002:a17:90b:2e46:b0:359:8957:7285 with SMTP id 98e67ed59e1d1-35de591e9bcmr14232090a91.3.1775583158886;
        Tue, 07 Apr 2026 10:32:38 -0700 (PDT)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-35e27d255easm26902a91.5.2026.04.07.10.32.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 07 Apr 2026 10:32:37 -0700 (PDT)
Message-ID: <1dd8324a-8cb8-43e2-9117-c52c37f1ad96@gmail.com>
Date: Tue, 7 Apr 2026 10:32:34 -0700
Precedence: bulk
X-Mailing-List: linux-fpga@vger.kernel.org
List-Id: <linux-fpga.vger.kernel.org>
List-Subscribe: <mailto:linux-fpga+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fpga+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] dt-bindings: fpga: add binding for Technologic
 Systems TS-73xx FPGA
To: Phil Pemberton <philpem@philpem.me.uk>, Moritz Fischer <mdf@kernel.org>,
 Xu Yilun <yilun.xu@intel.com>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>
Cc: Tom Rix <trix@redhat.com>, linux-fpga@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260407172730.1779804-1-philpem@philpem.me.uk>
 <20260407172730.1779804-2-philpem@philpem.me.uk>
Content-Language: en-US, fr-FR
From: Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <20260407172730.1779804-2-philpem@philpem.me.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 4/7/26 10:27, Phil Pemberton wrote:
> Add device tree binding documentation for the Altera Cyclone II FPGA
> found on Technologic Systems TS-7300 series boards, programmed via a
> CPLD memory-mapped interface.
> 
> Signed-off-by: Phil Pemberton <philpem@philpem.me.uk>

Reviewed-by: Florian Fainelli <f.fainelli@gmail.com>
-- 
Florian
