Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B47D32494D8;
	Thu, 20 Nov 2025 03:08:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763608114; cv=none; b=uex0eyRv2KLjpktws2+6Suwey2Jyd8skNmt+fssGgRN6e4wAtF63ZsDi2WyZPm88uEzCsUhg1oeKofCBQIbshO17dDISqLcNVPkqZrvOtfSAG5UoDbjbZDGjWdEt/BN4pRkIlXZmcd5eZCOqOpqpbqVn5RSu0WYHniJbKcYeBSw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763608114; c=relaxed/simple;
	bh=lc5qVOfGpZc7Ju12BmVM+4aEcSufr6VlaXBsPrw7rW8=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=mOZGszbLfJMYpVZJG7slEdpgRxvi0KlKhq/Ofa8rQJdZWcGqh+LQLjPDAW1cTIYGIy56Q5NtYE8PXB/gJNvRaAsfmwjjpBPgAQDy52Bi9t3aKVkqw7jWFsxIGgseRJPabC0AkV/t/73qDRO9HGmyzm3yzJI6evWE0A0wKW7Gvis=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TaSZz+mf; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TaSZz+mf"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5339CC4CEF5;
	Thu, 20 Nov 2025 03:08:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763608113;
	bh=lc5qVOfGpZc7Ju12BmVM+4aEcSufr6VlaXBsPrw7rW8=;
	h=Date:Subject:To:References:From:In-Reply-To:From;
	b=TaSZz+mfBcWPuMtErF74zUxdkuy8ckxKnlajdSuELRZNOs6ByQMsgf5yigVYwQyjX
	 z3kKWCDnT3phZ3fEvTGV4hOtwfFt3BgmR/YdSBHdBBl8YDntH0qUgdrtzMHPgkRtDJ
	 J6QHffVKIqMohXgD2rNzKgNmcbMF6PbCC7haKcS/8Vgjow+bDC4RKpa9lcM6i2wzS6
	 54i4CGkKYc70AQlkjKqeszeRQ+tagelZiCdaSJEhUWfZFmxGGuGia4ShzyH1ia+0xs
	 c1CtUc/1bCSPrZ/pVRfzskkQJpU1aVzJBjL2M2AT4UipDXxbCd20thkMf2qq3phN1/
	 d9UwzzUI/Z5uQ==
Message-ID: <ef29742c-834c-4f00-b6db-e9a0960b6d17@kernel.org>
Date: Wed, 19 Nov 2025 21:08:31 -0600
Precedence: bulk
X-Mailing-List: linux-fpga@vger.kernel.org
List-Id: <linux-fpga.vger.kernel.org>
List-Subscribe: <mailto:linux-fpga+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fpga+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 0/2] Enable FPGA Manager support for Agilex5
To: Khairul Anuar Romli <khairul.anuar.romli@altera.com>,
 Moritz Fischer <mdf@kernel.org>, Xu Yilun <yilun.xu@intel.com>,
 Tom Rix <trix@redhat.com>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Mahesh Rao <mahesh.rao@altera.com>,
 Ho Yin <adrian.ho.yin.ng@altera.com>,
 Niravkumar L Rabara <nirav.rabara@altera.com>, linux-fpga@vger.kernel.org,
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
References: <cover.1763518321.git.khairul.anuar.romli@altera.com>
Content-Language: en-US
From: Dinh Nguyen <dinguyen@kernel.org>
In-Reply-To: <cover.1763518321.git.khairul.anuar.romli@altera.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 11/18/25 20:26, Khairul Anuar Romli wrote:
> This patch series adds device tree bindings, driver and DTS updates to
> enable FPGA Manager functionality for Intel Agilex5 SoC.
> 
> These changes are intended to enable FPGA programming and FPGA management
> capabilities on Agilex5-based platforms.
> 

> ---
> Khairul Anuar Romli (2):
>    dt-bindings: fpga: stratix10: add support for Agilex5
>    arm64: dts: agilex5: add fpga-region and fpga-mgr nodes
> 

Applied!

Thanks,
Dinh
