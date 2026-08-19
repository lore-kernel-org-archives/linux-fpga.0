Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89EE137BE8D;
	Wed, 19 Aug 2026 11:23:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787138604; cv=none; b=Ckx3N8+uojy1FQlVSQ24gD/7anumloPvslDW9r4jPwbCxapJKweLPtpN8dANKj69QlfLO/mbFchSTW110hRz99xPxrc7z95J4Ie2y3QcYox/hwha5RLvLKtVizmHJf1yKkGi9MUj9Mi+lc9OsWFIioeVV+Hxf1Frzxj+84ShECg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787138604; c=relaxed/simple;
	bh=jKaTAdJGGqK6+UMzhVgkkQUmI8+HhXnlBb83O4imguY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YrHyqajn41Ifwba8upavXGCjPRTzS+quzVKrAdP+ZdBw880w7sNWegcggxGN0WKyiMGwmGbjP//Mt9uTOrfv9PxnoKl/V5+IgyT0ovO5Sv1YAavwQejgm+QWWPBEMskAsx6NCayrTBYEOO2t5JfozpB1vopib2Spc/8QXMrkBJI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=e05/5N3m; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="e05/5N3m"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9B6F11F00AC4;
	Wed, 19 Aug 2026 11:23:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787138603;
	bh=JFQyGWh5x/s+6BF8YDfZaE+nETKXjNmTHhHY128JOEs=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=e05/5N3mYllp7b0FvNKwUXGoWCH5uBBmY207AxXIx1+Vnrphk0xzGqydkA4QUYKmr
	 8EacOBuionOsOV9KkgRfWGsnUEG/9Ogane09PlkHJMEiOfomVK3HGn0jX8esyTVJe+
	 04Kvjj2eBTB5i+654kFmEH7V/NTYDHqr1NtG46EH3wsoPSDs+JYinrFqXIQt2b3WZD
	 QaKrLndzSQPF48YmZ5UjRpldS8I+oXD/3KMV9hNAuachUQj71rsTX5GOpbS0AlUJyh
	 h8tNpbZsQSTiDuCtGvV7DVZRi33smSHelGa8+LcSuAWByBaSg1VbgQDutYLfyPCly9
	 sXNfyZXxuG7Nw==
Message-ID: <7d5b8ce3-2f07-434b-afcf-927214959730@kernel.org>
Date: Wed, 19 Aug 2026 06:23:21 -0500
Precedence: bulk
X-Mailing-List: linux-fpga@vger.kernel.org
List-Id: <linux-fpga.vger.kernel.org>
List-Subscribe: <mailto:linux-fpga+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fpga+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] fpga: dfl: afu: prevent read-only port mappings from
 becoming writable
To: Abdifatah Suruur <suruurism@gmail.com>, linux-fpga@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, yilun.xu@intel.com, trix@redhat.com
References: <20260819084213.1560-1-suruurism@gmail.com>
Content-Language: en-US
From: Dinh Nguyen <dinguyen@kernel.org>
In-Reply-To: <20260819084213.1560-1-suruurism@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 8/19/26 03:42, Abdifatah Suruur wrote:
> afu_mmap() rejects writable mappings of port regions without the WRITE
> flag, but leaves VM_MAYWRITE set.  Userspace can map such a region
> read-only and then upgrade the mapping to writable with mprotect(),
> writing to FPGA port control/status registers the host owns.  A guest
> assigned an AFU can use this to reconfigure or reset the port and
> interfere with other tenants on the same FPGA.
> 
> Clear VM_MAYWRITE for regions without the WRITE flag, as i915 does for
> its read-only objects and as fixed in drm/vc4 (CVE-2026-68445) and
> drm/panthor (CVE-2024-53071) and ptp: vmclock (commit
> a5edadbae57e2298a56cf7a4e774a027905a331f).
> 
> Fixes: 1a1527cf5ddac ("fpga: dfl: add FPGA Accelerated Function Unit driver basic framework")

Please used exactly 12 characters for the hash ID.

Dinh
