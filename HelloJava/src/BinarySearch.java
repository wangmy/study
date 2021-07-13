public class BinarySearch {
    // 二分查找 - 基本的
    int binarySearch1(int[] nums, int target) {
        int left = 0;
        int right = nums.length - 1;
        // 每次搜索区间 [left, right]
        // 因为 right = numsL - 1，所以while取等，相当于[left, right], bu q
        while (left <= right) {
            // 不直接写成 (right+left) / 2，避免越界
            int mid = left + (right - left) / 2;
            if (nums[mid] == target) {
                return mid;
            } else if (nums[mid] < target) {
                // 搜索区间 [left, mid-1], mid, [mid+1, right]
                left = mid + 1;
            } else if (nums[mid] > target) {
                right = mid - 1;
            }
            return -1;
        }
        return -1;
    }

    // 二分查找 - 上述有弊端：比如 binarySearchh1([1,2,2,2,3], 2)，返回的index是2，实际可能是想找左边界或者右边界
    int left_bound(int[] nums, int target) {
        /**
         * ([1,2,2,2,3], 2)
         * 返回的index是1 （nums中小于2的元素是1个）
         * 
         * ([2,3,5,7], 1)
         *  返回的index是0 （nums中小于1的元素是0个）
         * 
         *  ([2,3,5,7], 8)
         *  返回的index是4 （nums中小于8的元素是4个）
         * 
         * 综上：函数的返回值（即left的值）取值区间是[left, nums.L)
         */
        if ( nums.length == 0 ) return -1;
        int left = 0;
        int right = nums.length;
        // 每次搜索区间是[left, right)，搜索左右侧边界的二分查找
        // 分割的区间是 [left , mid), (mid+1, left]

        while (left < right) {
            int mid = (left + right) / 2;
            if (nums[mid] == target) {
               /** 
                * 为什么该算法能够搜索左侧边界
                * nums[mid] == target 没有立刻return，而是缩小【搜索区间】的上界right，
                * 在区间[left, mid)中继续搜索，不断像左收缩，达到锁定左侧边界的目的
                */
                right = mid;
            } else if (nums[mid] > target) { 
                right = mid;
            } else if (nums[mid] < target) {
                left = mid + 1;
            }
        }
        /**
         * 为什么返回left，而不是right
         * 都是一样的，因为while终止的条件是left == right
         */
        return left;
    }

    // 二分查找， 把搜索区间改成[left, right]
    // [left, mid-1], mid , [mid+1, right]
    int left_bound2(int[] nums, int target) {
        int left = 0;
        int right = nums.length - 1;
        while (left <= right) {
            int mid = left + (right - left) / 2;
            if (nums[mid] == target) {
                right = mid - 1;
            } else if (nums[mid] > target) {
                right = mid - 1;
            } else if (nums[mid] < target) {
                left = mid + 1;
            }
        }
        // 因为退出条件是 left = right+1，所以需要做越界判断
        if ( left >= nums.length || nums[left] != target ) { return -1; }
        return left;
    }

    //
    int right_bound(int[] nums, int target) {
        int left = 0;
        int right = nums.length;
        while (left < right) {
            int mid = left + (right - left) / 2;
            if (nums[mid] == target) {
                /**
                 * 为什么可以找到右边侧
                 * left = mid + 1 是关键
                 */
                left = mid + 1;
            } else if(nums[mid] > target) {
                right = mid;
            } else if(nums[mid] < target) {
                left = mid + 1;
            }
        }
        //注意
        /**
         * while 终止条件是 left == right
         * 因为搜索右边侧的时候，left = mid + 1;
         */
        return left-1;
    }

    //
    int right_bound2(int[] nums, int target) {
        int left = 0;
        int right = nums.length - 1;
        while (left <= right) {
            int mid = left + (right - left) / 2;
            if (nums[mid] == target) {
                left = mid + 1;
            } else if (nums[mid] < target) {
                left = mid + 1;
            } else if (nums[mid] > target) {
                right = mid - 1;
            }
        }
        // 越界检查,right 可能 < 0
        if (right < 0 || nums[right] != target) { return -1; }
        return right;
    }

    // 左边侧（搜索区间开闭）& 右边侧（搜索区间开闭） & 最基本 =》逻辑统一
    /**
     * int left = 0
     * int right = L-1, while <=
     *      left = mid + 1;
     *      right = mid -1;
     *      普通： return mid；/ 右边侧 left = mid + 1； / 右边侧 right = mid - 1
     * 
     * int left = 0
     * int right = L, while <
     *      left = mid + 1;
     *      right = mid;
     *      普通： return mid；/ 右边侧 left = mid + 1； / 左边侧 right = mid
     * 
     * return 普通： -1；/ 右边侧 left - 1（开区间） / right（闭区间）& 边界检测<0 ； / 左边侧 left 
     */
}