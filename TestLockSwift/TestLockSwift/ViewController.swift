//
//  ViewController.swift
//  TestLockSwift
//
//  Created by wangmingyou on 2020/11/25.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
//        test_os_unfair_lock()
//        test_os_unfair_lock2()
//        test_pthread_mutex_recursive()
        test_semaphore()
    }
    
    func test_os_unfair_lock() {
        let lock = os_unfair_lock_t.allocate(capacity: 1)

        var number = 0
        DispatchQueue.global().async {
            os_unfair_lock_lock(lock)
            while number < 20 {
                number += 1
                print("os_unfair_lock in \(number)")
            }
            os_unfair_lock_unlock(lock)
        }

        DispatchQueue.global().async {
            os_unfair_lock_lock(lock)
            while number < 20 {
                number += 1
                print("os_unfair_lock outside \(number)")
            }
            os_unfair_lock_unlock(lock)
        }

        sleep(1)
        print("test_os_unfair_lock end \n\n\n")
    }

    func test_os_unfair_lock2() {
        let lock = os_unfair_lock_t.allocate(capacity: 1)
        
        var number = 0
        for _ in 1...1000 {
            DispatchQueue.global().async {
                var testClosure:(() -> Void)
                    // 实现闭包
                testClosure = {() -> Void in
                    os_unfair_lock_lock(lock)
                    while number < 20 {
                        number += 1
                        print("testClosure - os_unfair_lock in \(number)")
//                        testClosure()
                    }
//
                    os_unfair_lock_unlock(lock)
                }
                    // 调用
                testClosure()
                
            }
            
    //        DispatchQueue.global().async {
    //            var testClosure:((_ a: Int, _ b: Int) -> Void)
    //
    //                // 实现闭包
    //            testClosure = {  (a: Int, b: Int) -> Void in
    //                os_unfair_lock_lock(lock)
    //                while number < 20 {
    //                    number += 1
    //                    print("testClosure - os_unfair_lock in \(number)")
    //                }
    //                os_unfair_lock_unlock(lock)
    //            }
    //                // 调用
    //            testClosure(10,20);
    //
    //        }
        }
        
        

    //    DispatchQueue.global().async {
    //        os_unfair_lock_lock(lock)
    //        while number < 20 {
    //            number += 1
    //            print("os_unfair_lock outside \(number)")
    //        }
    //        os_unfair_lock_unlock(lock)
    //    }

        sleep(1)
        print("test_os_unfair_lock end \n\n\n")
    }
    
    /// 递归锁
    
    func test_pthread_mutex_recursive() {
        /// lock1 为递归锁，lock2/os_unfair_lock 为默认的锁(互斥)
        var lock1 = pthread_mutex_t()
        var attr = pthread_mutexattr_t()
        pthread_mutexattr_init(&attr)
        pthread_mutexattr_settype(&attr, PTHREAD_MUTEX_RECURSIVE)
        pthread_mutex_init(&lock1, &attr)
        pthread_mutexattr_destroy(&attr)
        var number1 = 0
        
        func run1() {
            pthread_mutex_lock(&lock1)
//            while number1 < 2000 {
            if number1 < 2000 {
                number1 += 1
                print("pthread_mutex_recursive lock1 \(number1)")
                run1()
            }
            pthread_mutex_unlock(&lock1)
            
            
        }
        
        var lock2 = pthread_mutex_t()
        pthread_mutex_init(&lock2, nil)
        let lock = os_unfair_lock_t.allocate(capacity: 1)
        var number2 = 0
        func run2() {
            pthread_mutex_lock(&lock2) // 死锁在这里
            if number2 < 2000 {
//                os_unfair_lock_lock(lock)
                number2 += 1
                print("pthread_mutex_recursive lock2 \(number2)")
//                os_unfair_lock_unlock(lock)
                run2()
            }
            pthread_mutex_unlock(&lock2)
            
            
        }
        
//        for _ in 1...10 {
//            let queue = DispatchQueue(label: "serial.com")
        let queue = DispatchQueue.global()
            queue.sync {
//                run1()
//                run2()
            }
//        }
        
        
//        sleep(1)
        print("test_pthread_mutex_recursive end \n\n\n")
    }
    
    func test_semaphore() {
        let semaphore = DispatchSemaphore(value: 1)
        var number2 = 0
        func run2() {
            semaphore.wait()
            if number2 < 2000 {
                number2 += 1
                print("pthread_mutex_recursive lock2 \(number2)")
                semaphore.signal()
                run2()
            }
            else {
                semaphore.signal()
            }
        }
        
        
        var number = 0
        DispatchQueue.global().async {
            run2()
//            semaphore.wait()
//            while number < 20 {
//                number += 1
//                print("semaphore in \(number)")
//            }
//            semaphore.signal()
        }

//        DispatchQueue.global().async {
//            semaphore.wait()
//            while number < 20 {
//                number += 1
//                print("semaphore outside \(number)")
//            }
//            semaphore.signal()
//        }

//        sleep(1)
        print("test_semaphore end \n\n\n")
    }

}

